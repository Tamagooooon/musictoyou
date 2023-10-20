class User::BookmarksController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @bookmark = current_user.bookmarks.build(bookmark_params)
    @post = @bookmark.post
    if @bookmark.valid?
      @bookmark.save
      redirect_to post_path(@post), notice: "お気に入りに登録しました。"
    end
  end
  
  def destroy
    @bookmark = Bookmark.find(params[:id])
    @post = @bookmark.post
    if @bookmark.destroy
      redirect_to post_path(@post), notice: "お気に入り登録を解除しました。"
    end
  end
  
  private
  
  def bookmark_params
    params.permit(:post_id)
  end
end
