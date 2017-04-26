module ApplicationHelper
  def m_icon(icon_name, options = {})
    icon_class_attr = "class='material-icons #{options[:class]}'"

    "<i #{icon_class_attr}>#{icon_name}</i>".html_safe
  end

  def time_in_words(time)
    from_time = (Time.now - time)/1.day
    if from_time >= 2
      return (I18n.localize time, format: :long)
    else
      return "#{time_ago_in_words(time)} trước"
    end
  end
end
