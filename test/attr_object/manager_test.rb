require 'test_helper'

include AttrObject

describe Manager do
  let(:manager) do
    m = Manager.new
    m.add_attribute :age, AgeAttr
    m
  end

  describe "with age value" do
    before { manager.set :age, 30 }
    let(:val) { manager.get :age }

    it "should get a `AgeAttr` value" do
      assert val.is_a?(AgeAttr)
    end
  end
end
