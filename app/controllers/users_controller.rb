class UsersController < ApplicationController
  before_action :set_user, only: [:add_nerge]

  def add_nerge
    current_user.nerges << @user
    flash[:notice] = 'Added nerge'
    redirect_to root_path
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
