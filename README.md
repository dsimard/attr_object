# `attr_object` : value objects for ruby on rails

[![Build Status](https://travis-ci.org/dsimard/attr_object.svg?branch=master)](https://travis-ci.org/dsimard/attr_object)

Value Objects should be used to have more capabilities on a model attribute in Rails. Example, a `phone_number` attribute that is simply a string could have methods to return the `area_code`, an unformated version or a formated standardized version.

## How to use

1. Create a value object in `app/values` (ex : [`app/values/phone_value.rb`](test/dummy/app/values/phone_value.rb))
2. Add this to your model : `attr_object :phone, :mobile, PhoneValue` (ex : [`app/model/user.rb`](test/dummy/app/models/user.rb))

### Use `DelegateClass` for you value objects (recommended)

[`DelegateClass`](http://ruby-doc.org/stdlib-2.3.0/libdoc/delegate/rdoc/Object.html) will keep your value compatible with the base class of the value while giving you the opportunity to add methods specific to that class of object. Let's take a look at a `PhoneValue` that would return an unformated value, `"323-216-3461"` would become `"3232163461"`.

````ruby
class PhoneValue < DelegateClass(String)
  def unformat
    self.gsub /\D*/, ""
  end
end
````

The _naked_ instance of `PhoneValue("323-216-3461")` still returns `"323-216-3461"`.

#### If you don't want to use `DelegateClass`

1. Create a value object in `app/values` (ex : [`app/values/position_value.rb`](test/dummy/app/values/position_value.rb))
2. Add this to your model : `attr_object :position, PositionValue` (ex : [`app/model/user.rb`](test/dummy/app/models/user.rb))
3. Make sure your value object has a `to_db` method that returns the right type
4. (_optional_) Make it `Comparable` for sorting

````ruby
class PositionValue
  include Comparable

  def <=>(other)
    to_db <=> other.to_db
  end

  def to_db
    @value.to_i
  end
end
````
