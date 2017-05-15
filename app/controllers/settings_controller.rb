class SettingsController < ApplicationController
  before_action :authenticate_user
  skip_after_action :verify_authorized

  def account
    @profile = current_user.profile
  end

  def update_account
    @profile = current_user.profile

    if @profile.update(profile_params)
      redirect_to account_settings_path, notice: "Cập nhật thành công"
    else
      flash.now[:alert] =  "Đã xảy ra lỗi"
      render "account"
    end
  end

  def notifications
    
  end

  private
    def profile_params
      params.require(:profile).permit(:username, :avatar)
    end
end
