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
        dropdown_template "Phản hồi", "btn teal white-text",
          [ "Nhận Patron", [:accept_nerge_request, user], :patch ],
          [ "Bỏ qua", [:decline_nerge_request, user], :delete ]
      else
        dropdown_template "Phản hồi", "btn teal white-text",
          [ "Nhận Nerge", [:accept_patron_request, user], :patch ],
          [ "Bỏ qua", [:decline_patron_request, user], :delete ]
      end
    else
      dropdown_template "Nhận", "btn-flat white add",
        [ "Nhận Nerge", [:nerge_request, user], :post ],
        [ "Nhận Patron", [:patron_request, user], :post ]
    end
  end

  private
    def should_hide_button_for?(user)
      !user_signed_in? || 
      current_user == user || 
      current_user.nerpatship?(user)
    end

    def dropdown_template(text, my_class, *links)
      str = "<a class='dropdown-button #{my_class}' 
        data-activates='nerpat-dropdown'>#{text}</a>"
      str += "<ul id='nerpat-dropdown' class='dropdown-content'>"
      links.each do |text, path, method|
        str += "<li>#{link_to text, path, method: method}</li>"
      end
      str += "</ul>"

      str.html_safe
    end
end
