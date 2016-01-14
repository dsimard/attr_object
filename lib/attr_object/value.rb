module AttrObject
  class Value
    attr_reader :klass
    attr_accessor :value

    def initialize klass, value
      @klass = klass
      @value = value
    end

    def value=(val)
      clear_cache
      @value = val
    end

    def cast
      return if @value.nil?
      @cast ||= @klass.new @value
    end

    private
    def clear_cache
      @cast = nil
    end
  end
end
