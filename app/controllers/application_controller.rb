class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception



  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def logged_in?
    !current_user.nil?
  end

  def login!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def require_logged_in
    redirect_to cats_url unless logged_in?
  end

  def require_logged_out
    redirect_to cats_url if logged_in?
  end


end
