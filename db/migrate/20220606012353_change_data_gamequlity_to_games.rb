class ChangeDataGamequlityToGames < ActiveRecord::Migration[6.1]
  def change
    change_column :games, :game_quality, :float

  end
end
