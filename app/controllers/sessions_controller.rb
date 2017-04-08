class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(request.env["omniauth.auth"])

    log_in(user)
    flash[:notice] = "Login success"
    redirect_to root_path
  end

  def destroy
    log_out
    flash[:notice] = "Bai Bai!!!"
    redirect_to root_path
  end
end
