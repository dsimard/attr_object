class User < ActiveRecord::Base
  object_value :phone, :mobile, PhoneValue
end
