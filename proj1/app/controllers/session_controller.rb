class SessionController < ApplicationController
  def new
  end

  def create
  	@user = User.find_by(name: params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      self.current_user = @user
      redirect_to root_path
    else
      flash.now[:error] = "Failed to log in"
      render :new
    end
  end

  def destroy
  	self.current_user = nil
    redirect_to root_path
  end
end
