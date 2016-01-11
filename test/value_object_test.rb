require 'test_helper'

class ValueObjectTest < ActiveSupport::TestCase
  DEFAULT_PHONE = "959-542-5256"
  DEFAULT_MOBILE = "878-858-5115"

  def user(phone: DEFAULT_PHONE, mobile: DEFAULT_MOBILE, position: nil)
    User.new phone: phone, mobile: mobile, position: position
  end

  test "should be a module" do
    assert_kind_of Module, ValueObject
  end

  test "should have the `value_object` method" do
    assert User.methods.include?(:value_object)
    assert ActiveRecord::Base.methods.include?(:value_object)
  end

  test "should return the right class on the attribute" do
    assert user.phone.is_a?(PhoneValue), "`phone` should be PhoneValue"
    assert user.mobile.is_a?(PhoneValue), "`mobile` should be PhoneValue"
  end

  test "should call a method from the value object" do
    assert_equal "9595425256", user.phone.unformat
  end

  test "`position` should be a PositionValue" do
    assert user(position:10).position.is_a?(PositionValue)
  end

  test "`position` should be updated as a `Fixnum`" do
    u = user position:10
    assert_equal 10, u.position.value
    u.position = 99
    assert u.save
    assert_equal 99, u.reload.position.value
  end

  test "should update position to next" do
    u = user position: 10

    u.position.next!
    assert_equal 11, u.position.value

    # TODO
    # assert_equal 11, u[:position], "should also be 11"

    assert u.save
    assert_equal 11, u.reload.position.value
  end

  test "two instances should have distinct values" do
    user_1 = user
    user_2 = user phone: "999-999-9999"

    refute_equal user_1.phone, user_2.phone
  end

  test "if value to nil, it's not instanciated" do
    assert_nil user.position
  end
end
