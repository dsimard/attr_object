module AttrObject
  class Manager
    attr_reader :attributes

    def initialize
      @attributes = {}
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
