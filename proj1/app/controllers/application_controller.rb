class ApplicationController < ActionController::Base
  def current_user=(user)
    session[:user_id] = user&.id
  end

  def current_user
    begin
      @user ||= User.find(session[:user_id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "You are currently not logged in. Please, log in!"
      redirect_to login_path
    end
  end

  def authenticated?
    current_user.present?
  end

  def authenticate!
    redirect_to login_path unless authenticated?
  end
end
