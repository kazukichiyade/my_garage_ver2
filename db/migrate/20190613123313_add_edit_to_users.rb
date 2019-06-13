class AddEditToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :a_word, :string
    add_column :users, :introduction, :text
  end
end
