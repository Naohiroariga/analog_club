class AddColumnsToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :impression, :text
    add_column :games, :score, :decimal, precision: 5, scale: 3
  end
end
