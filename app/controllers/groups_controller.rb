class GroupsController < ApplicationController
  before_action :authenticate_user
  before_action :set_group

  def show
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
      @group = Group.find(params[:id])
      authorize @group
    end 
end
