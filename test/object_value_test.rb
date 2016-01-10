require 'test_helper'

class ObjectValueTest < ActiveSupport::TestCase
  test "should be a module" do
    assert_kind_of Module, ObjectValue
  end

  test "should have a method" do
    assert User.methods.include?(:object_value)
  end
end
