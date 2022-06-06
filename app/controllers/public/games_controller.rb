class Public::GamesController < ApplicationController
  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    if @game.save
      redirect_to game_path(@game)
    else
      render "new"
    end
  end

  def edit
  end

  def show
  end

  def index
  end

  private

  def game_params
    params.require(:game).permit(:name, :player, :overview, :how_to_use, :game_quality, :strategic, :cooperation, :excitement, :luck, :image)
  end

end
