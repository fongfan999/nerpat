class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper

  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  protected
    def authenticate_user
      unless user_signed_in?
        session[:forwarding_url] = request.original_url if request.get?
        flash[:alert] =  "Bạn phải đăng nhập trước"
        redirect_to root_path
      end
    end

    def not_authorized
      redirect_to root_path, alert: "Bạn không có quyền truy cập "
    end
end
