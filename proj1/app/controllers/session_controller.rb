class SessionController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      self.current_user = @user
      redirect_to root_path
    else
      flash.now[:error] = "Failed to log in!"
      render :new
    end
  end

  def destroy
    if self.current_user == nil
      redirect_to login_path
    else
      self.current_user = nil
      begin
        redirect_to login_path
        flash[:success] = "Successfully logged out."
      rescue AbstractController::DoubleRenderError
      end
    end
  end
end
