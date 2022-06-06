class ChangeDataStrategicToGames < ActiveRecord::Migration[6.1]
  def change
    change_column :games, :strategic, :float
    change_column :games, :cooperation, :float
    change_column :games, :excitement, :float
    change_column :games, :luck, :float
  end
end
