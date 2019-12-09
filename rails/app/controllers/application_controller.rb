class ApplicationController < ActionController::Base
  def current_user=(user)
    session[:user_id] = user&.id
  end

  def current_user
    if session[:user_id] != nil
      @user ||= User.find(session[:user_id])
    end
  end
  helper_method :current_user

  def authenticated?
    current_user.present?
  end

  def authenticate!
    unless authenticated?
      flash[:error] = "You are currently not logged in. Please, log in!"
      redirect_to login_path
    end
  end
end
