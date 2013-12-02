class String

  def lively
    ["weee", "yeehaha", "yipeee"].sample + self
  end

  def reverse
    reverse = []
    self.each_char do |c| 
      reverse << c
    end
    reverse.reverse.join ""
  end

end 