class PositionValue
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def next!
    @value += 1
  end
end
