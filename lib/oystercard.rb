
class Oystercard

  attr_reader :balance, :entry_station, :exit_station

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(money)
    fail "Beyond limit of #{MAXIMUM_BALANCE}" if (balance + money) > MAXIMUM_BALANCE
    @balance += money
  end

  def in_journey?
    !@entry_station.nil?
  end

  def touch_in(entry_station)
    fail "Insufficient balance" if balance < MINIMUM_FARE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    @journeys << { entry_station: @entry_station, exit_station: @exit_station }
    @entry_station = nil
  end

  def journey_history
    @journeys
  end

  private

  def deduct(money)
    @balance -= money
  end

end
