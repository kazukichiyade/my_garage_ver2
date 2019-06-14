class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper #controller内どこでも使えるようになる
  # フラッシュメッセージに動きを付けるため必要
  add_flash_types :success, :danger, :info, :warning

  protect_from_forgery with: :exception
end
