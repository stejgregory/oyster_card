class Oystercard
DEFAULT_BALANCE = 0

  def initialize
    @balance = DEFAULT_BALANCE
    @in_use = false
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

  def deduct(amount)
    @balance = @balance - amount
  end

  def touch_in?
    @in_use = true
  end

  def touch_out?
    @in_use = false
  end

  def in_journey?
    @in_use
  end

end
