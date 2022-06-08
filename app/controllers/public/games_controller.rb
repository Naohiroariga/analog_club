class Public::GamesController < ApplicationController
  before_action :authenticate_user!

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
    @game = Game.find(params[:id])
    if @game.user_id == current_user.id
      render "edit"
    else
      redirect_to games_path
    end
  end

  def update
    @game = Game.find(params[:id])
    if @game.update(game_params)
      redirect_to game_path(@game)
    else
      render "edit"
    end
  end

  def show
    @game = Game.find(params[:id])
    @comment = Comment.new
  end

  def index
    @games = Game.all
  end

  private

  def game_params
    params.require(:game).permit(:name, :player, :overview, :how_to_use, :game_quality, :strategic, :cooperation, :excitement, :luck, :image)
  end

end
