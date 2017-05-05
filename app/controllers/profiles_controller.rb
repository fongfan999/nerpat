class ProfilesController < ApplicationController
  before_action :authenticate_user, except: :show
  before_action :set_profile, only: [:edit, :update]
  before_action :set_current_user_profile,
    only: [:connect_to_facebook, :disconnect_to_facebook]

  skip_after_action :verify_authorized, except: [:edit, :update]

  def show
    unless @profile = Profile.find_by_username(params[:username])
      flash[:alert] = "Không tìm thấy trang"
      redirect_to root_path
    end
  end

  def edit
    respond_to do |format|
      format.js
    end
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
    if @profile.update(facebook_uid: request.env["omniauth.auth"].uid)
      flash[:notice] = "Connect success to Facebook"
    else
      flash[:alert] = "Connect error"
    end

    redirect_to @profile
  end

  def disconnect_to_facebook
    if @profile.update(facebook_uid: nil)
      flash[:notice] = "Disconnected to Facebook"
    else
      flash[:alert] = "Cannot disconnect to facebook"
    end

    redirect_to @profile
  end

  private
    def set_profile
      @profile = Profile.find_by(username: params[:username])
      authorize @profile
    end

    def set_current_user_profile
      @profile = current_user.profile
    end

    def profile_params
      params.require(:profile).permit(:bio, :major_id, :username, :school_id, 
        :avatar, skill_ids: [])
    end
end
