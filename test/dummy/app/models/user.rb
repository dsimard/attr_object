class User < ActiveRecord::Base
  attr_object :phone, :mobile, PhoneValue
  attr_object :position, PositionValue
end
