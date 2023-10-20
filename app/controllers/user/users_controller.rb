class User::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @posts = @user.postspage(params[:page])
    bookmarks = Bookmark.where(user_id: current_user.id).pluck(:post_id)
    @bookmarks = Post.find(bookmarks)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image)
  end
end
