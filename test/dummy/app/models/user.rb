class User < ActiveRecord::Base
  attr_object :phone, :mobile, PhoneAttr
  attr_object :position, PositionAttr
end
