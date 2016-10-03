class Oystercard
DEFAULT_BALANCE = 0

  def initialize
    @balance = DEFAULT_BALANCE
  end

  def check_balance
    @balance
  end

  def topup(funds)
    if (@balance + funds) > 90
    "Error, this will exceed the £90 maximum balance."
    else
    @balance = @balance + funds
    end
  end

end
