module AttrObject
  class Manager
    def add_attribute attribute, klass
      @attributes ||= {}
      @attributes[attribute] = Value.new klass
    end

    def set attribute, value
      @attributes[attribute].value = value
    end

    def get attribute
      @attributes[attribute].cast
    end
  end
end
