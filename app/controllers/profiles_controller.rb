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
    if @profile.update(profile_params)
      flash[:notice] = "Update successfully"
      redirect_to @profile
    else
      flash.now[:alert] = "Update error"
      render :edit
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

    redirect_to @profile
  end

  def disconnect_to_facebook
    @profile = current_user.profile
    @profile.facebook_uid = nil
    if @profile.save
      flash[:notice] = "Disconnected to Facebook"
    else
      flash[:alert] = "Cannot disconnect to facebook"
    end
    redirect_to @profile
  end

  private
    def set_profile
      @profile = current_user.profile.find_by_username(params[:username])
    end

    def profile_params
      params.require(:profile).permit(:bio, :major_id, :username, :school_id, skill_ids: [])
    end
end
