class Oystercard

  DEFAULT_BALANCE = 0.0
  MAX_BALANCE = 90



  attr_reader :balance

  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = false
  end

  def check_balance
    @balance
  end

  def topup(funds)
    fail "Error, this will exceed the £#{MAX_BALANCE} maximum balance." if (balance + funds) > MAX_BALANCE
    @balance = @balance + funds
  end

  def deduct(amount)
    @balance = @balance - amount
  end

  def touch_in?
    if (@balance < 1.0)
      "Not enough funds on card."
    else
    @in_journey = true
    end
  end

  def touch_out?
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

end
