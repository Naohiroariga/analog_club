class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @model = params[:model]
    if @model == "game"
      if params[:new_date]
        @games = Game.looks(@word).order(created_at: :desc)
      elsif params[:favorite]
        all = Game.looks(@word)
        favorite = Game.find(Favorite.group(:game_id).order('count(game_id) desc').pluck(:game_id))

        @games = favorite - (favorite -all) + (all - favorite)
      else
        @games = Game.looks(@word)
      end
    elsif @model == "tag"
      if params[:new_date]
        @games = Tag.looks_tag(@word)
      elsif params[:favorite]
        all = Tag.looks_tag(@word)
        favorite = Game.find(Favorite.group(:game_id).order('count(game_id) desc').pluck(:game_id))

        @games = favorite - (favorite -all) + (all - favorite)
      else
       @games = Tag.looks_tag(@word)
      end
    end
    tags = []
    @games.each do |game|
      game.tags.each do |tag|
        tags << tag.tag
      end
      @tags = tags.uniq
    end
  end

  def filter
    @word = params[:word]
    @model = params[:model]
    @tag = params[:tag]
    search = Tag.looks_tag(@tag)
    if @model == "game"
      if params[:new_date]
        games = Game.looks(@word).order(created_at: :desc)
        @games = games - (games - search)
      elsif params[:favorite]
        games = Game.looks(@word)
        favorite = Game.find(Favorite.group(:game_id).order('count(game_id) desc').pluck(:game_id))
        filter = games - (games - search)
        @games = favorite - (favorite -filter) + (filter - favorite)
      else
        games = Game.looks(@word)
        @games = games - (games - search)
      end
    elsif @model == "tag"
      if params[:new_date]
        games = Game.where(params[:games]).order(created_at: :desc)
        @games = games - (games - search)
      elsif params[:favorite]
        games = Game.find(params[:games])
        favorite = Game.find(Favorite.group(:game_id).order('count(game_id) desc').pluck(:game_id))

        @games = favorite - (favorite -games) + (games - favorite)
      else
        games = Game.find(params[:games])
        @games = games - (games - search)
      end
    end
    tags = []
    @games.each do |game|
      game.tags.each do |tag|
        tags << tag.tag
      end
      @tags = tags.uniq
    end
  end
end
