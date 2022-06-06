class ChengeDetaPlayerToGames < ActiveRecord::Migration[6.1]
  def change
    change_column :games, :player, :string
  end
end
