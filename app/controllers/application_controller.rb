class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper #controller内どこでも使えるようになる
  # フラッシュメッセージに動きを付けるため必要
  add_flash_types :success, :danger, :info, :warning

  protect_from_forgery with: :exception
end

# 基本的なCRUD
# Create => 新規作成(new, create) POST/PUT
# Read   => データ一覧・個別の表示(index, show) GET
# Update => データの更新(edit, update) PUT/PATCH
# Delete => データの削除(delete) DELETE
