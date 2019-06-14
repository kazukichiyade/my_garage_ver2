class AddIndexToUsersEmail < ActiveRecord::Migration[5.1]
  # find_byはusersテーブルにindexを導入してるから使用可能(index = 辞書索引)
  def change
    add_index :users, :email, unique: true
  end
end
