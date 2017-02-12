class String

  REGEX = {
    email: /^[^@ \?]+@[^@\. \?]+\.\w{2,3}$/
  }.freeze

  def email?
    !!(self =~ REGEX[:email])
  end

end
