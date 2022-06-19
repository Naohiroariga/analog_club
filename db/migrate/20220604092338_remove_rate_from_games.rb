class RemoveRateFromGames < ActiveRecord::Migration[6.1]
  def change
    remove_column :games, :rate, :integer
  end
end
