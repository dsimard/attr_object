class PositionValue
  attr_accessor :position

  def initialize(position)
    @position = position
  end

  def next
    @position + 1
  end
end
