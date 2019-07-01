class PasswordResetsController < ApplicationController

  before_action :get_user_email, only:[:edit, :update]
  before_action :proper_user, only:[:edit, :update]
  before_action :time_deadline, only:[:edit, :update]

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

  def update

  end

  private

    def user_params
      # ストロングパラメーター
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user_email
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーか確認
    def proper_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # トークンが期限切れかどうか確認する
    def time_deadline
      if @user.password_reset_expired?
        flash[:danger] = "パスワードリセットの有効期限が切れております"
        redirect_to password_resets_new_url
      end
    end
end
