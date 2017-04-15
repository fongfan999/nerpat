class UsersController < ApplicationController
  before_action :authenticate_user
  before_action :set_nerge, only: %i{
    send_add_nerge_request 
    cancel_add_nerge_request 
    accept_add_patron_request 
    decline_add_patron_request
  }
  before_action :set_patron, only: %i{
    accept_add_nerge_request 
    decline_add_nerge_request 
    send_add_patron_request 
    cancel_add_patron_request
  }

  rescue_from ActiveRecord::RecordNotFound, with: :not_available 

  # Nerge
  def send_add_nerge_request
    current_user.send_nerpat_request_to(@nerge, "muốn nhận bạn làm Nerge")
    redirect_to root_path, notice: "Đã gửi yêu cầu tới Nerge"
  end

  def cancel_add_nerge_request
    if @nerge.decline_add_nerge_request_from(current_user)
      redirect_to root_path, notice: "Đã huỷ bỏ yêu cầu"
    else
      cannot_cancel
    end
  end

  def accept_add_nerge_request
    if current_user.accept_add_nerge_request_from(@patron)
      redirect_to root_path, notice: "Nhận Patron thành công"
    else
      not_available
    end
  end

  def decline_add_nerge_request
    current_user.decline_add_nerge_request_from(@patron)
    redirect_to root_path, alert: "Đã xoá yêu cầu"
  end

  # Patron
  def send_add_patron_request
    current_user.send_nerpat_request_to(@patron, "muốn nhận bạn làm Patron")
    redirect_to root_path, notice: "Đã gửi yêu cầu tới Patron"
  end

  def cancel_add_patron_request
    if @patron.decline_add_patron_request_from(current_user)
      redirect_to root_path, notice: "Đã huỷ bỏ yêu cầu"
    else
      cannot_cancel
    end
  end

  def accept_add_patron_request
    if current_user.accept_add_patron_request_from(@nerge)
      redirect_to root_path, notice: "Nhận Nerge thành công"
    else
      not_available
    end
  end

  def decline_add_patron_request
    current_user.decline_add_patron_request_from(@nerge)
    redirect_to root_path, alert: "Đã xoá yêu cầu"
  end

  def remove_nerge
    @nerge = current_user.nerges.find(params[:id])
    @nerge.update(patron_id: nil)
    @nerge.notifications.create(actor: current_user,
      action: "đã ngưng nhận bạn làm Nerge")

    redirect_to  current_user.profile, notice: "Removed nerge"
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Nerge hiện không tồn tại. Vui lòng thử lại"
    redirect_to current_user.profile
  end

  def remove_patron
    if @patron = current_user.patron
      @patron.notifications.create(actor: current_user,
        action: "đã ngưng nhận bạn làm Patron")
      current_user.update(patron_id: nil)
    end

    redirect_to current_user.profile, notice: "Removed patron"
  end

  private
    def set_nerge
      @nerge = current_user.available_nerges.find(params[:id])
    end

    def set_patron
      @patron = current_user.available_patrons.find(params[:id])
    end

    def cannot_cancel
      flash[:alert] = "Không thể huỷ bỏ yêu cầu. Vui lòng thử lại."
      redirect_to root_path
    end

    def not_available
      flash[:alert] = "Nerge/Patron này không thể nhận. Vui lòng thử lại."
      redirect_to root_path
    end
end
