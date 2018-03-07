class CommentsController < ApplicationController
  def create
    user = User.find_by_email(current_user_email)

    Comment.create({
      body: params[:comment][:body],
      post_uuid: params[:post_id],
      user: user,
    })

    redirect_to post_path(params[:post_id])
  end

  private

  def user_params
    params.require(:comment).permit(:body)
  end
end
