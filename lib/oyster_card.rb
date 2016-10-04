class Oystercard

  DEFAULT_BALANCE = 0.0



  attr_reader :balance

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
    if (@balance < 1.0)
      "Not enough funds on card."
    else
    @in_use = true
    end
  end

  def touch_out?
    @in_use = false
  end

  def in_journey?
    @in_use
  end

end
