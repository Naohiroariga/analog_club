class Public::UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @username = @user.name
    if @user.id ==current_user.id
      render "edit"
    else
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    @username = @user.name
    if @user.update(user_params)
      redirect_to user_path(current_user), notice: "プロフィールを編集しました。"
    else
      render "edit"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :comment, :profile_image, :email)
  end
end
