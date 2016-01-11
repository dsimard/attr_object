class IdValue
  attr_accessor :id

  def initialize(id)
    @id = id
  end

  def next
    @id + 1
  end
end
