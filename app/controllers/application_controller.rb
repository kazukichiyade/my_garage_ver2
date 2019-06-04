class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper #controller内どこでも使えるようになる
end
