class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :not_authorize

  protected
    def authenticate_user
      unless user_signed_in?
        session[:forwarding_url] = request.original_url if request.get?
        flash[:alert] =  "Bạn phải đăng nhập trước"
        redirect_to root_path
      end
    end

    def not_authorize
      redirect_to root_path, notice: "Không tìm thấy trang"
    end
end
