class User < ActiveRecord::Base
  object_value :phone, :mobile, PhoneValue
  object_value :id, IdValue
end
