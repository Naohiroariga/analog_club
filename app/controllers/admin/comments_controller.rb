class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @game = Game.find(params[:game_id])
    @comment = Comment.find(params[:id])
    @comment.update(is_delete: params[:is_delete])
    redirect_to admin_game_path(@game)
  end
end
