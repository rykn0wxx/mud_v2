# == Schema Information
#
# Table name: dim_contacts
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_dim_contacts_on_name  (name) UNIQUE
#

class DimContact < ApplicationRecord
  validates :name, uniqueness: true, presence: true


  def self.import(file)
    spreadsheet = open_spreadsheet(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      product = find_by_id(row["id"]) || new
      product.attributes = row.to_hash.slice(*accessible_attributes)
      product.save!
    end
  end
end
