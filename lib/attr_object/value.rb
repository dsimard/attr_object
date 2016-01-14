module AttrObject
  class Value
    attr_reader :klass
    attr_accessor :value

    def initialize klass, value
      @klass = klass
      @value = value
    end

    def value=(val)
      @value = val
    end

    def cast
      return if @value.nil?
      @cast ||= @klass.new @value
    end
  end
end
