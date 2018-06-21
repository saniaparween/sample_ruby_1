class UsersController < ApplicationController

  def index
    @user = User.all

  end


  def new
      @messageFromControllerUserNotExist = "Please sign up"
  end

  def show
    @user = User.find(params[:id])
  end

  def login
      @messageFromControllerFailure = "Incorrect email or password"
  end

  def checkValidUser
    #binding.pry
    @emailFromLoginView = params[:user][:email]
    @passwordFromLoginView= params[:user][:password]
    #emailFromDb = User.find_by(:email => @emailFromLoginView)

      if User.exists?(:email => @emailFromLoginView)
        passwordFromDb = User.where(email: @emailFromLoginView).select("password")
         if( passwordFromDb == @passwordFromLoginView)
              redirect_to users_profile_path
          else
              redirect_to users_login_path
          end
      else
        redirect_to new_user_path
      end
 end

  def profile
      @messageFromControllerSuccess = "successfully logged in"

  end

  def create
    #binding.pry
    emailFromView = params[:user][:email]

    if User.exists?(:email => emailFromView)
       redirect_to users_login_path
    else
       @user = User.new(user_params)
       @user.save!
       #flash[:success] = "You signed up successfully"
       #flash[:color]= "valid"
       redirect_to @user
    end
end

private
  def user_params
    params.require(:user).permit(:email, :password)
  end


end
