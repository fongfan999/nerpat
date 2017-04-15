class PagesController < ApplicationController
  def show
    if user_signed_in?
      @available_nerges = current_user.available_nerges
        .exclude_requested_nerpaters(current_user)
      @available_patrons = current_user.available_patrons
        .exclude_requested_nerpaters(current_user)
    else
      @available_patrons = @available_nerges = User.all
    end
  end
end
