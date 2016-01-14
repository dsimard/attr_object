module AttrObject
  class Manager
    attr_reader :attributes

    def initialize
      @attributes = {}
    end

    def add_attribute attribute, klass
      @attributes[attribute] = Value.new klass
    end

    def set klass, attribute, value
      @attributes[attribute] = Value.new klass, value
    end

    def get attribute
      return if @attributes[attribute].nil?
      @attributes[attribute].cast
    end
  end
end
