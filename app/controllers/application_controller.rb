class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # rescue_from ActiveRecord::RecordNotFound, with: :not_authorize
  

  def own_permision(profile)
    user_signed_in? && current_user.own?(profile)
  end
  helper_method :own_permision

  protected
    def authenticate_user
      unless user_signed_in?
        session[:forwarding_url] = request.original_url if request.get?
        flash[:alert] =  "Bạn phải đăng nhập trước"
        redirect_to root_path
      end
    end

    def not_authorize
      redirect_to root_path, notice: "Bạn không có quyền truy cập"
    end
end
