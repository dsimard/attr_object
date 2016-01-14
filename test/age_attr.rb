class AgeAttr < DelegateClass(Fixnum)
  def decade
    (self/10)+1
  end

  def to_next_decade!
    __setobj__ self + 10
  end
end
