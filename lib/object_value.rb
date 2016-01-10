module ObjectValue
  extend ActiveSupport::Concern

  module ClassMethods
    def object_value
    end
  end

  ActiveRecord::Base.send :include, ObjectValue
end
