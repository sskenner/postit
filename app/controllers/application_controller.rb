class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:error] = 'sorry, you must be logged in to do that'
      redirect_to root_path
    end
  end

  def access_denied
    flash[:error] = 'you cannot do that'
    redirect_to root_path
  end

  def require_admin
    access_denied unless current_user && current_user.admin?
  end
end
