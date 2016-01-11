class PhoneValue < DelegateClass(String)
  include Comparable

  # See https://en.wikipedia.org/wiki/North_American_Numbering_Plan

  FORMAT = /(\d{3})-(\d{3})-(\d{4})/

  def unformat
    gsub /\D*/, ""
  end

  def area_code
    match(FORMAT)[1]
  end

  def central_office
    match(FORMAT)[2]
  end

  def subscriber_number
    match(FORMAT)[3]
  end

  # We sort on subscriber number
  def <=>(other)
    subscriber_number <=> other.subscriber_number
  end
end
