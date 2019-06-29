class PasswordResetsController < ApplicationController

  before_action :get_user_email, only:[:edit, :update]
  before_action :proper_user, only:[:edit, :update]
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.password_reset_email
      flash[:info] = "パスワード変更の確認メールを送信しました"
      redirect_to root_url
    else
      flash[:danger] = "該当するメールアドレスがありません"
      render 'new'
    end
  end

  def edit
  end

  private

    def get_user_email
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーか確認
    def proper_user
      unless (@user && @user.activated? &&
              @user.authentivcated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
end
