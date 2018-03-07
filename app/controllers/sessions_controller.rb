class SessionsController < ApplicationController
  def new
  end

  def create
    email = user_params['email']

    if User.find_by_email(email)
      session[:current_user_email] = email
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    session[:current_user_email] = nil
    redirect_to root_path
  end

  def posts
    @posts = Post.all_for_user_email(session[:current_user_email])
  end

  def comments
    @comments = Comment.all_for_user_email(session[:current_user_email])
  end

  private

  def user_params
    params.require(:user).permit(:email)
  end
end
