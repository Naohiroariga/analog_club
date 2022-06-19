class Public::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @game = Game.find(params[:game_id])
    @comment = current_user.comments.new(comment_params)
    @comment.game_id = @game.id
    @comment.save
    redirect_to request.referer
  end

  def destroy
    @game = Game.find(params[:game_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
