class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)

    if @user.save
      flash[:notice] = 'user registered .. now login'
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def users_params
    params.require(:user).permit(:username, :password, :time_zone, :phone)
  end
end
