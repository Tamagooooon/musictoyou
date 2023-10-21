class User::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def index
    @posts = Post.page(params[:page])
    if params[:new_post]
       @posts = Post.new_post
    elsif params[:old_post]
       @posts = Post.old_post
    else
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    end
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:user_id, :body, :title, :image, :audio, :tag_ids[] )
  end
end
