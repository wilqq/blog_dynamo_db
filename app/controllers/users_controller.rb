class UsersController < ApplicationController
  def new
  end

  def create
    puts(user_params)
    User.create(user_params)
    session[:current_user_email] = user_params['email']
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
