class NotificationsController < ApplicationController
  before_action :authenticate_user
  skip_after_action :verify_authorized

  def nerpat_requests
    @nerpat_requests = current_user.notifications.nerpat_requests
    @nerpat_requests.unread.mark_all_as_read
    @nerpat_requests = @nerpat_requests.page(params[:page])
  end

  def index
    @notifications = current_user.notifications.without_nerpat_requests
    @notifications.unread.mark_all_as_read
    @notifications = @notifications.page(params[:page])
  end

  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy
  end
end
