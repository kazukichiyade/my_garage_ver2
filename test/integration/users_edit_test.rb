require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:kazukichi)
  end

  name = "kazukichi"
  email = "kazuki@example.com"
  a_word = "マツダアテンザ"
  introduction = "こんにちは"

  test "users_edit not_complate" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: "",
                            email: email,
                            password: "",
                            password_confirmation: "",
                            a_word: a_word,
                            introduction: introduction } }
    assert_template 'users/edit'
  end

  test "users_edit complate" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { name: name,
                                    email: email,
                                    password: "",
                                    password_confirmation: "",
                                    a_word: a_word,
                                    introduction: introduction } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal a_word, @user.a_word
    assert_equal introduction, @user.introduction
  end
end
