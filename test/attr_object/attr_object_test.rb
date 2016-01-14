require 'test_helper'

describe AttrObject do
  DEFAULT_PHONE = "959-542-5256"
  DEFAULT_MOBILE = "878-858-5115"

  let(:user) do
    User.create phone: DEFAULT_PHONE, mobile: DEFAULT_MOBILE
  end

  it "should be a module" do
    assert_kind_of Module, AttrObject
  end

  describe "User" do
    it "should have the `attr_object` method" do
      assert User.methods.include?(:attr_object)
      assert ActiveRecord::Base.methods.include?(:attr_object)
    end
  end

  describe PhoneAttr do
    it "should return the right class on the attribute" do
      assert user.phone.is_a?(PhoneAttr), "`phone` should be PhoneValue"
      assert user.mobile.is_a?(PhoneAttr), "`mobile` should be PhoneValue"
    end

    it "should call a method from the value object" do
      assert_equal "9595425256", user.phone.unformat
    end

    it "should be respond to numbering plan" do
      assert_equal "959", user.phone.area_code
      assert_equal "542", user.phone.central_office
      assert_equal "5256", user.phone.subscriber_number
    end

    it "should be delegated" do
      assert_equal "959", user.phone_area_code
    end

    describe "with two users" do
      let(:user_2) do
        User.create phone: "111-111-1111"
      end

      it "two instances should have distinct values" do
        refute_equal user.phone, user_2.phone
      end

      it "should be sorted on phone.subscriber_number" do
        users = [user, user_2]
        users.each &:save
        _(users.sort_by(&:phone)).must_equal [user_2, user]
      end
    end
  end

  describe PositionAttr do
    let(:user) do
      User.create position: 0
    end

    it "`position` should be a PositionValue" do
      _(user.position).must_be_instance_of PositionAttr
    end

    it "`position` should be updated as a `Fixnum`" do
      assert_equal 0, user.position.value
      user.position = 99
      assert user.save
      assert_equal 99, user.reload.position.value
    end

    it "should update position to next" do
      assert_equal 1, user.position.next!
      assert_equal 1, user.position.value

      # TODO
      # assert_equal 1, u[:position], "should also be updated"
      assert user.save
      assert_equal 1, user.reload[:position]
    end

    it "#to_db" do
      _(user.position.to_db).must_be_instance_of Fixnum
    end

    it "`reload` should clear cache" do
      user.save

      user.position.next!
      assert_equal 1, user.position.value

      user.reload
      assert_equal 0, user[:position]
      skip "TODO"
      assert_equal 0, user.position.value
    end

    describe "without position" do
      let(:user) { User.create }

      it "if value to nil, it's not instanciated" do
        assert_nil user.position
      end
    end
  end

  describe AgeAttr do
    let(:user) { User.create }

    it "should return nil" do
      user.age.must_be_nil
    end

    describe "with an age" do
      let(:user) { User.create age:30 }

      it "should have a value" do
        user.age.must_equal 30
      end
    end
  end
end
