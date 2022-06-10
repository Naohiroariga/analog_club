class Admin::GamesController < ApplicationController
  before_action :authenticate_admin!

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

  def show
  end

  def edit
  end
end
