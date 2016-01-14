require 'test_helper'

include AttrObject

describe Value do
  let(:val) { Value.new AgeAttr, 30 }
  let(:cast) { val.cast }

  it "should return a `AgeAttr`" do
    assert cast.is_a?(AgeAttr)
  end

  it "should call method on attribute" do
    assert_equal 4, cast.decade
  end

  it "should change @value but keep the current object" do
    assert_equal 40, cast.to_next_decade!
    assert_equal 5, cast.decade
  end
end
