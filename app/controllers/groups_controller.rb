class GroupsController < ApplicationController
  before_action :authenticate_user
  before_action :set_group, only: [:edit, :update]

  rescue_from ActiveRecord::RecordNotFound, with: :unauthorize_group

  def show
    @group = current_user.groups.find(params[:id])
  end

  def edit
  end

  def update
    if @group.update(params.require(:group).permit(:name))
      flash[:notice] = "Group updated"
      redirect_to @group
    else
      flash.now[:alert] = "Cannot update"
      render :edit
    end
  end

  private
    def set_group
      @group = current_user.groups.find(params[:id])
    end
    
    def unauthorize_group
      redirect_to root_path
      flash[:alert] = "Bạn không có quyền truy cập"
    end
end
