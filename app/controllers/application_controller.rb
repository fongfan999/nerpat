class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  protected
    def authenticate_user
      unless user_signed_in?
        flash[:alert] =  "Please log in to continue"
        redirect_to root_path
      end
    end
end
