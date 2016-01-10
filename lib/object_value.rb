module ObjectValue
  extend ActiveSupport::Concern

  module ClassMethods
    def object_value(*fields, klass)
      fields.each do |field|
        define_method field do
          klass.new self[field]
        end
      end
    end
  end

  ActiveRecord::Base.send :include, ObjectValue
end
