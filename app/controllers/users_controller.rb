class UsersController < ApplicationController
  before_action :authenticate_user

  def add_nerge
    @user = current_user.available_nerges.find(params[:id])
    current_user.nerges << @user
    flash[:notice] = 'Added nerge'
    redirect_to root_path
  end

  def remove_nerge
    @user = current_user.nerges.find(params[:id])
    @user.update_columns(patron_id: nil)
    flash[:alert] = 'Removed nerge'
    redirect_to username_path(username: current_user.profile.username)
  end
end
