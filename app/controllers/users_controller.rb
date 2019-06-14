class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def signup #new
    @user = User.new
  end

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
      redirect_to @user
      flash[:success] = "プロフィールを更新しました"
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
end

