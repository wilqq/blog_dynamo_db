class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user_email
    session[:current_user_email]
  end

  helper_method :current_user_email
end
