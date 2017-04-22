class UsersController < ApplicationController
  before_action :authenticate_user

	include NerpatRequests

  def remove_nerge
    if current_user.remove_nerge(params[:id])
      redirect_to current_user.profile, notice: "Đã nhưng nhận làm Nerge"
    else
      flash[:alert] = "Nerge hiện không tồn tại. Vui lòng thử lại"
      redirect_to current_user.profile
    end
  end

  def remove_patron
    if current_user.remove_patron(params[:id])
      redirect_to current_user.profile, notice: "Đã nhưng nhận làm Nerge"
    else
      flash[:alert] = "Patron hiện không tồn tại. Vui lòng thử lại"
      redirect_to current_user.profile
    end
  end
end
