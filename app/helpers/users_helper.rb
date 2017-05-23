module UsersHelper
  def nerpat_request_button(user)
    return if should_hide_button_for?(user)

    if current_user.pending_nerpats.exists?(user.id)
      link_to "Đang chờ ...",
        (current_user.nerge_request_with?(user) ? 
        [:cancel_nerge_request, user] : [:cancel_patron_request, user]),
        method: :delete, class: "btn-flat grey lighten-2 grey-text"
    elsif current_user.requested_nerpats.exists?(user.id)
      if user.nerge_request_with?(current_user)
        dropdown_template user, "Phản hồi", "btn white primary-text",
          [ "Nhận Patron", [:accept_nerge_request, user], :patch ],
          [ "Bỏ qua", [:decline_nerge_request, user], :delete ]
      else
        dropdown_template user, "Phản hồi", "btn white primary-text",
          [ "Nhận Nerge", [:accept_patron_request, user], :patch ],
          [ "Bỏ qua", [:decline_patron_request, user], :delete ]
      end
    else
      links = []
      if current_user.available_nerges.exists?(user.id)
        links << [ "Nhận Nerge", [:nerge_request, user], :post ]
      end
      if current_user.available_patrons.exists?(user.id)
        links << [ "Nhận Patron", [:patron_request, user], :post ]
      end

      return if links.empty?
      dropdown_template user, "Nhận", "btn white primary-text", *links
    end
  end

  private
    def should_hide_button_for?(user)
      !user_signed_in? || 
      current_user == user || 
      current_user.nerpatship?(user)
    end

    def dropdown_template(user, text, my_class, *links)
      str = "<a class='dropdown-button #{my_class}' 
        data-activates=#{dom_id(user, :nerpat_dropdown)}>#{text}</a>"
      str += "<ul id=#{dom_id(user, :nerpat_dropdown)} class='dropdown-content'>"
      links.each do |link_text, path, method|
        str += "<li>#{link_to link_text, path, method: method}</li>"
      end
      str += "</ul>"

      str.html_safe
    end
end
