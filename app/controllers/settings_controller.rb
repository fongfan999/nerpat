class SettingsController < ApplicationController
  before_action :authenticate_user
  skip_after_action :verify_authorized

  def account
    @account = current_user
  end

  def update_account
    if current_user.update(account_params)
      flash[:notice] = "Cập nhật thành công"
    else
      flash[:alert] = "Đã xảy ra lỗi"
    end

    redirect_to account_settings_path
  end

  def notifications
    
  end

  private
    def account_params
      params.require(:user).permit(:username, :avatar)
    rescue ActionController::ParameterMissing
      {}
    end
end
