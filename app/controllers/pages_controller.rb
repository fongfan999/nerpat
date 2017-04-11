class PagesController < ApplicationController
  def index
    if user_signed_in?
      @available_nerges = current_user.available_nerges
      @available_patrons = current_user.available_patrons
    else
      @available_patrons = @available_nerges = User.all
    end
  end
end
