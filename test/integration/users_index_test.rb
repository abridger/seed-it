require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @badger = users(:badger)
    @ferret = users(:ferret)
  end

  test "index including pagination" do
    log_in_as(@badger)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    User.paginate(page: 1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
    end
  end

  test "index as admin including delete links" do
   log_in_as(@badger)
   get users_path
   assert_template 'users/index'
   first_page_of_users = User.paginate(page: 1)
   first_page_of_users.each do |user|
     assert_select 'a[href=?]', user_path(user), text: user.name
     unless user == @badger
       assert_select 'a[href=?]', user_path(user), text: 'Delete'
     end
   end
   assert_difference 'User.count', -1 do
     delete user_path(@ferret)
   end
 end

  test "index as non-admin" do
    log_in_as(@ferret)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end
end
