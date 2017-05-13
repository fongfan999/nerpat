class SettingsController < ApplicationController
  before_action :authenticate_user
  skip_after_action :verify_authorized, only: :account

  def account
    
  end
end
