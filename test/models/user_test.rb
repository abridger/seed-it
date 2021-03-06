require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.create(name: "Weasel McWeasel",
                        email: "weasel@mcweasel.com",
                        password: "WeaselsRule",
                        password_confirmation: "WeaselsRule")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 256
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = [
      "badger@badger.com",
      "BADGER@badger.COM",
      "A_BADG-ER@badger.mcbadger.org",
      "badger.mcbadger@badger.jp",
      "badger+mcbadger@badger.cn"
    ]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = [
      "badger@mcbadger,com",
      "badger_at_mcbadger.org",
      "badger.mcbadger@badger.",
      "badger@badger_badger.com",
      "badger@badger+mcbadger.com",
      "badger@mcbadger..com"
    ]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Mixed@CaSE.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.email
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

  test "associated meadows should be destroyed" do
    @user.save
    @user.meadows.create!(name: "Test meadow", description: "Lorem ipsum")
    assert_difference 'Meadow.count', -1 do
      @user.destroy
    end
  end
end
