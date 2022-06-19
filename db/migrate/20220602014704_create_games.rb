class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.string :name
      t.integer :player
      t.text :overview
      t.text :how_to_use
      t.integer :rate
      t.integer :game_quality
      t.integer :strategic
      t.integer :cooperation
      t.integer :excitement
      t.integer :luck

      t.timestamps
    end
  end
end
