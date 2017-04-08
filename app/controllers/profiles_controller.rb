class ProfilesController < ApplicationController
  before_action :authenticate_user
  before_action :set_profile

  def show
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:notice] = "Update successfully"
      redirect_to @profile
    else
      flash.now[:alert] = "Update error"
      reder :edit
    end
  end


  def connect_to_facebook
    @profile = current_user.profile
    @profile.facebook_uid = request.env["omniauth.auth"].uid
    if @profile.save
      flash[:notice] = "Connect success to Facebook"
      redirect_to @profile
    else
      flash.now[:alert] = "Connect error"
      render :show
    end
  end

  private
    def set_profile
      @profile = current_user.profile
    end

    def profile_params
      params.require(:profile).permit(:bio, :major_id, :username)
    end
end
