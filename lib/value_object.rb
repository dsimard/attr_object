module ValueObject
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    def value_object(*fields, klass)
      fields.each do |field|
        instance_var_name = "@value_object_#{field}"

        # The reader (ex : `user.phone`)
        define_method field do
          # Use the cached instance if available
          instance_var = instance_variable_get instance_var_name
          return instance_var if instance_var

          # Cache the instance
          inst_var = klass.new(read_attribute(field))
          instance_variable_set instance_var_name, inst_var
        end

        # The writer (ex : `user.phone=`)
        define_method "#{field.to_s}=" do |val|
          instance_variable_set instance_var_name, nil
          write_attribute field, val
        end
      end
    end
  end

  ActiveRecord::Base.send :include, ValueObject
end
