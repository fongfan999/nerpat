class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  

  def own_permision(profile)
    user_signed_in? && current_user.own?(profile)
  end
  helper_method :own_permision

  protected
    def authenticate_user
      unless user_signed_in?
        flash[:alert] =  "Please log in to continue"
        redirect_to root_path
      end
    end
end
