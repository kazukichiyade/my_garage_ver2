require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  # Homeページのviewのlayoutやlinkが合ってるかのテスト
  test "layout links" do
    get root_path
    assert_template 'home_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "title"
  end
end
