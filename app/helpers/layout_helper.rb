module LayoutHelper

  def title(page_title, show_header = true)
    content_for(:title) { page_title.to_s }
    @show_header = show_header
  end

  def show_header?
    @show_header
  end

  def set_to_active(ctrl_name)
    controller_name == ctrl_name
  end

  def navbar_link_to(label, path, options={})
    nav_icon = content_tag(:span, :class => 'nav-icon') do
      fa_icon('fw ' + options[:fa_ico])
    end
    nav_title = content_tag(:span, label, :class => 'nav-title')
    active_when = options.delete(:active_when) { Hash.new }
    active = active_when.all? do |key, value|
      case value
        when Regexp
          params[key].to_s =~ value
        else
          params[key].to_s == value
      end
    end

    content_tag(:li, :class => (active ? 'treeview active' : 'treeview')) do
      link_to path do
        nav_icon + nav_title
      end
    end
  end

end
