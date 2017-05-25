class SettingsController < ApplicationController
  before_action :authenticate_user
  skip_after_action :verify_authorized

  def account
    @account = current_user
  end

  def update_account
    if current_user.update(account_params)
      redirect_to account_settings_path, notice: "Cập nhật thành công"
    else
      flash.now[:alert] =  "Đã xảy ra lỗi"
      render "account"
    end
  end

  def notifications
    
  end

  private
    def account_params
      params.require(:user).permit(:username, :avatar)
    end
end
