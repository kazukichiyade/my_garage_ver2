class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save

    else
      render 'new'
    end
  end

  # 外部から使えない
  private

    # Strong Parameters(必須のパラメータと許可されたパラメータを指定)
    def user_params
      params.require(:user).permit(:name, :email, :password,
                      :password_confirmation)
    end
end

