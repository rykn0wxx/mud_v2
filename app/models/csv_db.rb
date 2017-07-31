class CsvDb
  class << self
    def importer(file, model, lookup, keyval)
      @lookup = lookup
      @keyval = keyval
      @model = model;
      @ifile = open_the_file(file)
      @heads = prepare_heads
      @rep_vals = replacer_value(lookup, keyval)
      process_file
      import_results
    end

    def import_results
      @model.create!(@results)
    end

    def prepare_heads
      headers = []
      @ifile.row(1).each do |head|
        headers << head.to_sym
      end
      headers
    end

    def process_file
      lines = []
      (2..@ifile.last_row).each do |i|
        row = Hash[[@heads, @ifile.row(i)].transpose]
        lines << row
      end
      @results = cycle(lines)
    end

    def cycle(lines)
      lines.each_with_object([]) do |iv, arr|
        iv[@lookup.to_sym] = @rep_vals[iv[@lookup.to_sym]]
      end
      lines
    end

    def replacer_value(colname, valkey)
      qry_vals = []
      @ifile.parse(val_to_change: colname.to_s).each do |cell|
        qry_vals << cell.values[0]
      end
      qry_plck = @model.where(valkey => qry_vals).pluck(valkey.to_sym, :id)
      qry_opts = Hash[*qry_plck.flatten]
      qry_opts
    end

    def open_the_file(file)
      case File.extname(file.original_filename)
        when ".csv"
          then Roo::CSV.open(file.path, { header: true })
        when ".xlsx"
          then Roo::Excelx.new(file.path, { header_line: 1 })
        else raise "Unknown file type: #{file.original_filename}"
      end
    end
  end
end
