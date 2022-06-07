class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    game = Game.find(params[:game_id])
    favorites = current_user.favorites.new(game_id: game.id)
    favorites.save
    redirect_to request.referer
  end

  def destroy
    game = Game.find(params[:game_id])
    favorites = current_user.favorites.find_by(game_id: game.id)
    favorites.destroy
    redirect_to request.referer
  end

end
