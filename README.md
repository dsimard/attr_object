# Value Objects in Rails

What is a value object?

## Documentation

### Create a value object

1. Create a value object in `app/values` (ex : [`app/values/phone_value.rb`](test/dummy/app/values/phone_value.rb))
2. Add this call in your model : `value_object :phone, :mobile, PhoneValue` (ex : [`app/model/user.rb`](test/dummy/app/models/user.rb))

### Use `DelegateClass` for you value objects

[`DelegateClass`](http://ruby-doc.org/stdlib-2.3.0/libdoc/delegate/rdoc/Object.html) will keep your value compatible with the base class of the value while giving you the opportunity to add methods specific to that class of object. Let's take a look at a `PhoneValue` that would return an unformated value, `"323-216-3461"` would become `"3232163461"`.

````ruby
class PhoneValue < DelegateClass(String)
  def unformat
    self.gsub /\D*/, ""
  end
end
````

The _naked_ instance of `PhoneValue("323-216-3461")` still returns `"323-216-3461"`.

### If not using `DelegateClass`

- Create method named `to_db`
