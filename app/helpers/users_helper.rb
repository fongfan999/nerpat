module UsersHelper
  def display_nerpat_request_button(user, text, link, mthd, custom_class)
    if current_user.pending_nerpats.exists?(user.id)
      link_to "Đã gửi yêu cầu", (current_user.nerge_request_with?(user) ? 
        [:cancel_nerge_request, user] : [:cancel_patron_request, user]),
        method: :delete, class: "btn btn-flat grey lighten-2 grey-text",
        data: { confirm: "Bạn có chắc chắn muốn hủy yêu cầu này" }
    else
      link_to text, link, method: mthd, class: "btn #{custom_class}"
    end
  end
end
