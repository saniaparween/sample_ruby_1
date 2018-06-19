class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def new

  end

  def show
  end

  def create
    @user = Users.new(params)

    @user.save
    redirect_to @user
  end

  private
  def params
    params.require(:user).permit(:email, :password)
  end

end
