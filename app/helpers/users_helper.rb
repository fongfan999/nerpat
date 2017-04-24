module UsersHelper
  def nerpat_request_button(user)
    return if !user_signed_in? || current_user == user

    if current_user.pending_nerpats.exists?(user.id)
      link_to "Đang chờ ...",
        (current_user.nerge_request_with?(user) ? 
        [:cancel_nerge_request, user] : [:cancel_patron_request, user]),
        method: :delete, class: "btn-flat grey lighten-2 grey-text"
    else
      "
        <a class='dropdown-button btn-flat white add'
          data-activates='nerpat-dropdown'>Nhận</a>
        
        <ul id='nerpat-dropdown' class='dropdown-content'>
          <li>#{link_to "NERGE", [:nerge_request, user], method: :post}</li>
          <li>#{link_to "PATRON", [:patron_request, user], method: :post}</li>
        </ul>
      ".html_safe
    end
  end
end
