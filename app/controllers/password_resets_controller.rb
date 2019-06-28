class PasswordResetsController < ApplicationController
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
end
