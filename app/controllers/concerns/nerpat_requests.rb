module NerpatRequests
  extend ActiveSupport::Concern

  included do
    before_action :set_nerge, only: %i{
      nerge_request 
      cancel_nerge_request 
      accept_patron_request 
      decline_patron_request
    }
    before_action :set_patron, only: %i{
      accept_nerge_request 
      decline_nerge_request 
      patron_request 
      cancel_patron_request
    }

    rescue_from ActiveRecord::RecordNotFound, with: :not_available 
  end

  def nerge_request
    current_user.nerpat_request_to(@nerge, @type)
    redirect_to @nerge.profile, notice: "Đã gửi yêu cầu tới Nerge"
  end

  def cancel_nerge_request
    current_user.cancel_nerpat_request_to(@nerge, @type)
    redirect_to @nerge.profile, notice: "Đã huỷ bỏ yêu cầu"
  end

  def accept_nerge_request
    debugger
    current_user.accept_nerpat_request_from(@patron, @type)
    redirect_to @patron.profile, notice: "Nhận Patron thành công"
  end

  def decline_nerge_request
    current_user.decline_nerpat_request_from(@patron, @type)
    redirect_to @patron.profile, alert: "Đã xoá yêu cầu"
  end
  
  def patron_request
    current_user.nerpat_request_to(@patron, @type)
    redirect_to @patron.profile, notice: "Đã gửi yêu cầu tới Patron"
  end

  def cancel_patron_request
    current_user.cancel_nerpat_request_to(@patron, @type)
    redirect_to @patron.profile, notice: "Đã huỷ bỏ yêu cầu"
  end

  def accept_patron_request
    current_user.accept_nerpat_request_from(@nerge, @type)
    redirect_to @nerge.profile, notice: "Nhận Nerge thành công"
  end

  def decline_patron_request
    current_user.decline_nerpat_request_from(@nerge, @type)
    redirect_to @nerge.profile, alert: "Đã xoá yêu cầu"
  end

  private

  def set_nerge
    @nerge = current_user.available_nerges.find(params[:id])
    @type = 'nerge'
  end

  def set_patron
    @patron = current_user.available_patrons.find(params[:id])
    @type = 'patron'
  end

  def not_available
    flash[:alert] = "Đã xảy ra lỗi. Vui lòng thử lại."
    redirect_to root_path
  end
end
