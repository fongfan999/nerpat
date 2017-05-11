module NotificationsHelper
  def nerpat_request_dropdown_content(notification)
    str = "<li>"
    str += link_to 'Đồng ý', accept_nerpat_request_path(notification),
      method: :patch, class: 'accept'
    str += "</li><li>"
    str += link_to 'Bỏ qua', decline_nerpat_request_path(notification),
      method: :delete, class: 'delete'
    str += "</li>"

    str.html_safe
  end

  private
    def accept_nerpat_request_path(notification)
      [ notification.nerge_request? ? 
        :accept_nerge_request : :accept_patron_request, notification.actor ]
    end

    def decline_nerpat_request_path(notification)
      [ notification.nerge_request? ? 
        :decline_nerge_request : :decline_patron_request, notification.actor ]
    end
end
