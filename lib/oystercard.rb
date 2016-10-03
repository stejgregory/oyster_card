class Oystercard
  attr_reader :balance

  MAXIMUM_BALANCE = 90

  def initialize(balance = 0)#, limit = self.class::DEFAULT_LIMIT)
    @balance = balance
    # @limit = limit
  end

  def top_up(amount)
    fail "Card limit of £#{MAXIMUM_BALANCE} has been reached." if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end
  
  def deduct(amount)
    @balance -= amount
  end
end