class PositionAttr
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def next!
    @value += 1
  end

  def to_db
    @value
  end
end
