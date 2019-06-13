require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:kazukichi)
  end

  test "users_edit not_complate " do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                            email: "kazuki@example.com",
                            password: "foo",
                            password_confirmation: "bar" } }
    assert_template 'users/edit'
  end
end
