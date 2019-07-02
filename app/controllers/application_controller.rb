class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper #controller内どこでも使えるようになる
  include UsersHelper
  # フラッシュメッセージに動きを付けるため必要
  add_flash_types :success, :danger, :info, :warning

  protect_from_forgery with: :exception
end

# 基本的なCRUD
# Create => 新規作成(new, create) POST/PUT
# Read   => データ一覧・個別の表示(index, show) GET
# Update => データの更新(edit, update) PUT/PATCH
# Delete => データの削除(delete) DELETE

# _urlはredirect_toする場合のみ, 主にcontrollerに用いられる

# render
# render で明示的に view を指定すると、指定した view が表示されます。
# create アクションの後に、show ページを表示したい場合など、view を変更等

# redirect
# view の表示には直接は関係なく、新たな HttpRequest が発行されます。※GETのみ