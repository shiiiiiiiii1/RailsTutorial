require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:michael)
	end

	test "unsuccessful edit" do
		get_edit_user_path(@user)
		assert_template 'users/edit'
		path user_path(@user), user: { name: "", email: "foo@invalid", password: "foo", password_confirmation: "bar" }
		assert_template 'user/edit'
	end
end
