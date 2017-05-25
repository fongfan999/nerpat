class SessionsController < ApplicationController
  skip_after_action :verify_authorized

  def create
    if user = User.from_omniauth(request.env["omniauth.auth"])
      log_in(user)

      if user.profile.created_at == user.profile.updated_at
        redirect_to user.profile and return
      end
    else
      flash[:alert] = "Vui lòng dùng email sinh viên để sử dụng"
    end

    redirect_back_or root_path
  end

  def destroy
    log_out
    redirect_to root_path
  end
end
