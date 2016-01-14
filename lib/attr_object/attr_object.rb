module AttrObject
  module AttrObject
    extend ActiveSupport::Concern

    included do
      def obj_attr_manager
        @obj_attr_manager ||= Manager.new
      end

      before_save do
        manager = obj_attr_manager

        # Cast each database attribute and assign value to the object before saving
        manager.attributes.select{|attr| has_attribute? attr}.each do |attribute, value|
          cast = value.cast
          cast = cast.to_db if cast.respond_to? :to_db
          self[attribute] = cast
        end
      end

      class << self
        def attr_object(*fields, klass)
          fields.each do |field|
            # The reader (ex : `user.phone`)
            define_method field do
              obj_attr_manager.get field
            end

            # The writer (ex : `user.phone=`)
            define_method "#{field}=" do |val|
              obj_attr_manager.set klass, field, val
            end
          end
        end
      end
    end

    ActiveRecord::Base.send :include, AttrObject
  end
end
