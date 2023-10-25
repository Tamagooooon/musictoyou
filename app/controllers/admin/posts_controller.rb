class Admin::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :if_not_admin
  before_action :set_post, only: [:index, :show, :edit, :update, :destroy]

  def index
    @post = Post.page(params[:page])
    if params[:new_post]
      @posts = Post.new_post
    elsif params[:old_post]
      @posts = Post.old_post
    else
      @posts = params[:tag_id].present? ? Tag.find(params[:tag_id]).posts : Post.all
    end
    if params[:keyword]
      @posts = @posts.search(params[:keyword]).page(params[:page])
    else
      @post = @posts.page(params[:page])
    end
    @keyword = params[:keyword]
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post.id)
    else
      render :index
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private

  def if_not_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_post
    @post = post.find(params[:id])
  end
end
