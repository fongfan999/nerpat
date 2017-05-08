class NotificationsController < ApplicationController
  before_action :authenticate_user
  skip_after_action :verify_authorized

  def index
    @notifications = current_user.notifications.without_nerpat_requests
    @notifications.unread.mark_all_as_read
    @notifications = @notifications.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def nerpat_requests
    @nerpat_requests = current_user.notifications.nerpat_requests.recent

    respond_to do |format|
      format.js
    end
  end
end
