module SessionsHelper
  def user_signed_in?
    current_user.is_a? User
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
  end

  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_out
    @current_user = session[:user_id] = nil
  end
end
