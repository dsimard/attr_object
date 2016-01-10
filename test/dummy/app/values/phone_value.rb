class PhoneValue < DelegateClass(String)
  def unformat
    self.gsub /\D*/, ""
  end
end
