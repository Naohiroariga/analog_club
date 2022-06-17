class Public::GamesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.user_id = current_user.id
    tag_list = params[:game][:tag_name].split(',')
    if @game.save
      @game.save_tags(tag_list)
      redirect_to game_path(@game), notice: "ゲーム情報の投稿をしました"
    else
      render "new"
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    redirect_to games_path, notice: "ゲーム情報を削除しました。"
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
    tag_list = params[:game][:tag_name].split(',')
    if @game.update(game_params)
      @game.save_tags(tag_list)
      redirect_to game_path(@game), notice: "ゲーム情報を編集しました"
    else
      render "edit"
    end
  end

  def show
    @game = Game.find(params[:id])
    @comment = Comment.new
  end

  def index
    if params[:new_date]
      @games = Game.all.order(created_at: :desc)
    elsif params[:favorite]
      favorite = Game.find(Favorite.group(:game_id).order('count(game_id) desc').pluck(:game_id))
      all = Game.all
      @games = favorite + (all - favorite)
    else
      @games = Game.all
    end
    tags = []
    @games.each do |game|
      game.tags.each do |tag|
        tags << tag.tag
      end
      @tags = tags.uniq
    end

  end

  private

  def game_params
    params.require(:game).permit(:name, :player, :overview, :how_to_use, :game_quality, :strategic, :cooperation, :excitement, :luck, :image)
  end

end
