class ProfilesController < ApplicationController
  before_action :authenticate_user, except: :show
  before_action :set_profile, only: [:edit, :update]

  def show
    unless @profile = Profile.find_by_username(params[:username])
      flash[:alert] = "Page not found"
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    # debugger
    if @profile.update(profile_params)
      flash[:notice] = "Update successfully"
      redirect_to username_path(username: @profile.username)
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
    else
      flash[:alert] = "Connect error"
    end

    redirect_to username_path(username: @profile.username)
  end

  private
    def set_profile
      @profile = current_user.profile.find_by_username(params[:username])
    end

    def profile_params
      params.require(:profile).permit(:bio, :major_id, :username, :school_id)
    end
end
