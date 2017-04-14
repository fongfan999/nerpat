class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :unauthorize_group
  

  def own_permision(profile)
    user_signed_in? && current_user.own?(profile)
  end
  helper_method :own_permision

  protected
    def authenticate_user
      unless user_signed_in?
        flash[:alert] =  "Bạn phải đăng nhập trước"
        redirect_to root_path
      end
    end

    def unauthorize_group
      redirect_to root_path
      flash[:alert] = "Bạn không có quyền truy cập"
    end
end
