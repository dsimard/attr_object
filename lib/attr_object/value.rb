module AttrObject
  class Value
    attr_reader :klass
    attr_accessor :value

    def initialize klass, value=nil
      @klass, @value = klass, value
    end

    def cast
      @klass.new @value
    end
  end
end
