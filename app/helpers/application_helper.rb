module ApplicationHelper
  def m_icon(icon_name, options = {})
    icon_class_attr = "class='material-icons #{options[:class]}'"

    "<i #{icon_class_attr}>#{icon_name}</i>".html_safe
  end
end
