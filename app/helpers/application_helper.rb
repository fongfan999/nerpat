module ApplicationHelper
  def m_icon(icon_name, options = {})
    icon_class_attr = "class='material-icons #{options[:class]}'"

    "<i #{icon_class_attr}>#{icon_name}</i> #{options[:text]}".html_safe
  end

  def display_time(time)
    if (Time.zone.now - time) > 1.day
      l(time, format: "%d %B, %Y lúc %H:%M")
    else
      "#{time_ago_in_words(time)} trước"
    end
  end
end
