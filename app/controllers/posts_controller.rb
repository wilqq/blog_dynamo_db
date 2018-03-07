class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by_uuid(params[:id])
    @comments = Comment.all_for_post(params[:id])
  end

  def new
  end

  def create
    user = User.find_by_email(current_user_email)
    Post.create(post_params.merge(user: user))

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
