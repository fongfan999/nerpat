class ProfilesController < ApplicationController
  before_action :authenticate_user

  def show
    @profile = current_user.profile
  end

  def connect_to_facebook
    @profile = current_user.profile
    @profile.facebook_uid = request.env["omniauth.auth"].uid
    if @profile.save
      flash[:notice] = "Connect success to Facebook"
      redirect_to @profile
    else
      flash.now[:alert] = "Coonect error"
      render :show
    end
  end
end
