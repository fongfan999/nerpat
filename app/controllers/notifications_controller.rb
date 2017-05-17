class NotificationsController < ApplicationController
  before_action :authenticate_user
  skip_after_action :verify_authorized

  def nerpat_requests
    @nerpat_requests = current_user.notifications.nerpat_requests
    @nerpat_requests.unread.mark_all_as_read
    @nerpat_requests = @nerpat_requests.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def index
    @notifications = current_user.notifications.without_nerpat_requests
    @notifications.unread.mark_all_as_read
    @notifications = @notifications.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
    # redirect_to notifications_path, notice: "Đã xóa thông báo"
  end
end
