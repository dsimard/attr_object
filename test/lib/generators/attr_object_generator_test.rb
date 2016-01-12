require 'test_helper'
require 'generators/attr_object/attr_object_generator'

class AttrObjectGeneratorTest < Rails::Generators::TestCase
  tests AttrObjectGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test "generator runs without errors" do
    assert_nothing_raised do
      run_generator %w[phone]
    end

    assert_file "app/attr_objects/phone_attr.rb", /class PhoneAttr/
  end

  test "generator with class" do
    assert_nothing_raised do
      run_generator %w[position fixnum]
    end

    assert_file "app/attr_objects/position_attr.rb", /class PositionAttr < DelegateClass\(Fixnum\)/
  end

  test "generator with invalid class" do
    assert_nothing_raised do
      run_generator %w[phone invalid_ruby_class]
    end

    assert_file "app/attr_objects/phone_attr.rb", /class PhoneAttr < DelegateClass\(InvalidRubyClass\)/
  end
end
