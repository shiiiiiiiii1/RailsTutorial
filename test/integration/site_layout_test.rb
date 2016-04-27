require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "layout links" do
    get root_path			#root_path (/) を呼び出した
    assert_template 'static_pages/home'			#root_pathとstatic_pages/homeが同じビューであるか確認している
    assert_select "a[href=?]", root_path, count: 2
    # ?にroot_pathを代入してそういうルートパスが存在するかどうかを確認している。htmlファイルに2つあるからカウント2となっている
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    get signup_path
  	assert_select "title", full_title("Sign up")
  end
end
