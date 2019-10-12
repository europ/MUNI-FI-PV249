class ApplicationController < ActionController::Base
  def current_user=(user)
    session[:user_id] = user&.id
  end

  def current_user
    @user ||= User.find(session[:user_id])
  end

  def authenticated?
    current_user.present?
  end

  def authenticate!
    redirect_to login_path unless authenticated?
  end
end
