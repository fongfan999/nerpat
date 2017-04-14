class GroupsController < ApplicationController
  before_action :authenticate_user
  before_action :set_group
  before_action :authorization_patron, except: :show


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

    def authorization_patron
      unless @group.patron_id == current_user
        flash[:alert] = "Chỉ có partron mới được chỉnh sửa" 
        redirect_to @group
      end
    end
    
end
