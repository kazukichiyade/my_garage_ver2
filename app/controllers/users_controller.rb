class UsersController < ApplicationController
  # editかupdateの処理がされる直前にlogged_in_userメソッドが実行(:onlyを渡す事で指定できる)
  before_action :logged_in_user, only:[:edit, :update]
  before_action :correct_user, only:[:edit, :update]

  def index
    @all_user = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def signup #new
    @user = User.new
  end

  # アカウント作成
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "アカウントを作成しました"
      redirect_to @user #@user == user_url(@user)
    else
      render 'signup'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    # 更新に成功した場合
    if @user.update_attributes(user_params)
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # 外部から使えない
  private

    # Strong Parameters(必須のパラメータと許可されたパラメータを指定)
    def user_params
      params.require(:user).permit(:name, :email, :password,
                      :password_confirmation, :a_word, :introduction)
    end

    #before_action

    # ログイン済みユーザーか確認
    def logged_in_user
      # 渡させれたユーザーがログイン済みではない場合
      unless logged_in?
        store_location
        flash[:danger] = "ログインしてください"
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      # unless文(後置) current_user?が成り立たない場合redirect_toが発動
      unless current_user?(@user)
        redirect_to(root_url)
        flash[:danger] = "無効な操作です"
      end
    end

end

