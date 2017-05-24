class UsersController < ApplicationController
  before_action :authenticate_user
  skip_after_action :verify_authorized

  include NerpatRequests

  def show
    user = User.find(params[:id])
    redirect_to user.profile
  end

  def remove_nerge
    current_user.remove_nerge(params[:id]) ? head(:ok) : head(:bad_request)
  end

  def remove_patron
    current_user.remove_patron(params[:id]) ? head(:ok) : head(:bad_request)
  end
end
