require 'test_helper'

class MeadowTest < ActiveSupport::TestCase

  def setup
    @badger = users(:badger)
    @meadow = @badger.meadows.build(name: "Test meadow", description: "Lorem ipsum")
  end

  test "should be valid" do
    assert @meadow.valid?
  end

  test "user id should be present" do
    @meadow.user_id = nil
    assert_not @meadow.valid?
  end

  test "description should be present" do
    @meadow.description = "   "
    assert_not @meadow.valid?
  end
end
