class AddAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    # default: false(デフォルトでは管理者になれない)
    add_column :users, :admin, :boolean, default: false
  end
end
