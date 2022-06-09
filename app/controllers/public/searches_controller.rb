class Public::SearchesController < ApplicationController
  def search
    @word = params[:word]
    @games = Game.looks(@word)

  end
end
