class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  def login_required
    redirect_to :root_url unless current_user
  end

  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
