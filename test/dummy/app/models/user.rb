class User < ActiveRecord::Base
  value_object :phone, :mobile, PhoneValue
  value_object :position, PositionValue
end
