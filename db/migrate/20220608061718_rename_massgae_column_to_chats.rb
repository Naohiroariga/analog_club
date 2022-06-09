class RenameMassgaeColumnToChats < ActiveRecord::Migration[6.1]
  def change
    rename_column :chats, :massage, :message
  end
end
