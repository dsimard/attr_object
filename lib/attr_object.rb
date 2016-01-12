module AttrObject
  extend ActiveSupport::Concern

  included do
    before_validation do
      fields = self.class.attr_object_fields || []

      fields.each do |field|
        value = send field
        value = value.to_db if value.respond_to? :to_db

        send "#{field}=", value
      end
    end

    cattr_accessor :attr_object_fields
    class << self
      def attr_object(*fields, klass)
        self.attr_object_fields ||= []
        self.attr_object_fields += fields

        fields.each do |field|
          instance_var_name = "@attr_object_#{field}"

          # The reader (ex : `user.phone`)
          define_method field do
            return if read_attribute(field).nil?

            # Use the cached instance if available
            instance_var = instance_variable_get instance_var_name
            return instance_var if instance_var

            # Cache the instance
            inst_var = klass.new read_attribute(field)
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
  end

  ActiveRecord::Base.send :include, AttrObject
end
