# `attr_object` : value objects for ruby on rails

[![Build Status](https://travis-ci.org/dsimard/attr_object.svg?branch=master)](https://travis-ci.org/dsimard/attr_object)

Value Objects are used to add methods on model attributes in Rails. Example, a `phone_number` attribute that is simply a string could have methods to return the `area_code`, an unformated version or a formated standardized version.

## Installation

Include the gem in your Gemfile:

`gem "attr_object"`

Then follow these instructions to create your first `attr_object` :

1. Create a value object with `rails generate attr_object attribute_name [type]` (ex: `rails generate attr_object phone fixnum`). `type` is optional.
2. File is created in `app/attr_objects` (ex : [`app/attr_objects/phone_value.rb`](test/dummy/app/attr_objects/phone_value.rb))
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

## Why use `attr_object`?

To explain why, I will once again use the infamous `phone` attribute which a `String`.

### Slim down your models

To deal with phone numbers, we often end up with a mess of methods like this.

````ruby
class User < ActiveRecord::Base
  def unformat_phone
    # ...
  end

  def format_phone
    # ...
  end

  def area_code
    # ...
  end

  private
  def phone_to_i
    # ...
  end
end
````

`attr_object` helps you unclutter that mess.

````ruby
class User < ActiveRecord::Base
  attr_object :phone, PhoneAttr
end
````

### Keep responsibilities where they belong

According to the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle), methods about the `phone` attribute don't belong in your `User` model.

### Rails is not just MVC

We often build applications as if we could write code in just three different places : models, views or controllers. And if things go wild, we rely on concerns and helpers. That should not be the case.
