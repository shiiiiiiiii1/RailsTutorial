require 'test_helper'

class UserTest < ActiveSupport::TestCase
	def setup
		@user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
	end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do			#nameは存在していますか？のテスト
		@user.name = " "
		assert_not @user.valid?
	end

	test "email should be present" do
		@user.email = " "
		assert_not @user.valid?
	end

	test "name should not be too long" do			#nameの長さは51文字未満ですか？のテスト
		@user.name = "a" * 51
		assert_not @user.valid?
	end

	test "email should not be too long" do
		@user.email = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end

	test "email validation should accept valid addresses" do			#有効なメールアドレスであるか確認する
		valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
		valid_addresses.each do |valid_address|
			@user.email = valid_address
			assert @user.valid?, "#{valid_address.inspect} should be valid"
		end
	end

	test "email validation should reject invalid addresses" do			#無効なメールアドレスではないか確認する
		invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.foo@bar_baz.com foo@bar+baz.com]
		invalid_addresses.each do |invalid_address|
			@user.email = invalid_address
			assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
		end
	end

	test "email addresses should be unique" do
		# ローカル変数は、英小文字または「＿」で始まるもの
		duplicate_user = @user.dup			#@userと同じメールアドレスであるかどうかの確認 / クローンを制作した感じ
		duplicate_user.email = @user.email.upcase			#@userのメールの大小を区別しない / 大文字に変換
		@user.save
		assert_not duplicate_user.valid?
	end

	test "password should be present (nonblank)" do
		@user.password = @user.password_confirmation = "" * 6
		assert_not @user.valid?
	end

	test "password should have a minimum length" do
		@user.password = @user.password_confirmation = "" * 5
		assert_not @user.valid?
	end

end









