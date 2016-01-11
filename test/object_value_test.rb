require 'test_helper'

class ObjectValueTest < ActiveSupport::TestCase
  DEFAULT_PHONE = "959-542-5256"
  DEFAULT_MOBILE = "878-858-5115"

  def user(phone: DEFAULT_PHONE, mobile: DEFAULT_MOBILE, position: nil)
    User.new phone: phone, mobile: mobile
  end

  test "should be a module" do
    assert_kind_of Module, ObjectValue
  end

  test "should have the method" do
    assert User.methods.include?(:object_value)
    assert ActiveRecord::Base.methods.include?(:object_value)
  end

  test "should return the right class on the attribute" do
    assert user.phone.is_a?(PhoneValue), "`phone` should be PhoneValue"
    assert user.mobile.is_a?(PhoneValue), "`mobile` should be PhoneValue"
  end

  test "should call a method from the object value" do
    assert_equal "9595425256", user.phone.unformat
  end

  test "`id` should be an IdValue" do
    assert user(position:10).position.is_a?(PositionValue)
  end
end
