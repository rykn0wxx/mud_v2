module ApplicationHelper

  def navbar_linker(label, path, options={})
    treeview = options[:treeview] || ''
    nav_title = content_tag(:span, label, :class => 'nav-title')
    nav_icon = content_tag(:span, :class => 'nav-icon') do
      fa_icon('fw ' + (options[:fa_ico] || 'cube'))
    end
    nav_title = nav_icon + nav_title if options[:fa_ico].present?
    nav_tool = content_tag(:span, :class => 'nav-tools visibile-xs') do
      fa_icon('fw arrow')
    end
    active_when = options.delete(:active_when) { Hash.new }
    active = false
    if active_when.size != 0
      active = active_when.all? do |key, value|
        case value
        when Regexp
          params[key].to_s =~ value
        else
          params[key].to_s == value
        end
      end
    end
    linker = link_to(path) do
      nav_title + nav_tool
    end
    content_tag(:li, :class => (active ? treeview + ' active' : treeview)) do
      yield linker if block_given?
      link_to(path) do
        nav_title
      end
    end
  end

end
