class User < ActiveRecord::Base
  attr_object :phone, :mobile, PhoneAttr
  attr_object :position, PositionAttr

  # Optional - you can delegate to the `attr_object`
  # if you're worried about the [Law of Demeter](https://en.wikipedia.org/wiki/Law_of_Demeter)
  delegate :area_code, to: :phone, prefix: true
end
