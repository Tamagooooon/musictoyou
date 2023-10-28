class Admin::UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def show
    @user = User.find(params[:id])
    @users = User.all.page(params[:page])
    @posts = @user.posts
    bookmarks = Bookmark.where(@user_id).pluck(:post_id)
    @bookmarks = Post.find(bookmarks)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    flash[:notice] = "会員情報を編集しました"
    redirect_to admin_user_path
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :profile_image, :is_deleted)
  end
end
