class AddIdDeleteToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :is_delete, :boolean, defult: false
  end
end
