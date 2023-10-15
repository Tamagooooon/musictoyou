class UserController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post = @user.post.page(params[:page])
  end

  def edit
  end
end
