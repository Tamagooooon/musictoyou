class Admin::PostCommnentsController < ApplicationController
class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  
  def create
    post = Post.find(params[:post_id])
    comment = post_comments.new(post_comment_params)
    comment.post_id = post.id
    comment.save
    redirect_to admin_post_path(post)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to admin_post_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
end
