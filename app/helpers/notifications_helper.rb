module NotificationsHelper
  def nerpat_request_dropdown_content(notification)
    str = "<li>"
    str += link_to m_icon('check', text: 'Đồng ý'),
      accept_nerpat_request_path(notification), method: :patch
    str += "</li><li>"
    str += link_to m_icon('clear', text: 'Bỏ qua'),
      decline_nerpat_request_path(notification), method: :delete
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
