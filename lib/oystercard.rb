
require_relative 'journey'

class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @balance = 0
    @journey_log = []
  end

  def top_up(money)
    fail "Beyond limit of #{MAXIMUM_BALANCE}" if (balance + money) > MAXIMUM_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    fail "Insufficient balance" if balance < MINIMUM_FARE
    charge_penalty_fare if @current_journey # (!@journey_log.empty? && !@journey_log.last.complete?) ##CHANGE ME
    @current_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    if @journey_log.last.complete?
       journey = Journey.new
       @journey_log << journey.end(exit_station) ##CHANGE ME
    else
      @curent_journey.end(exit_station) ##Change ME
      @current_journey=nil
    end
  end

  def journey_history
    @journey_log
  end

  private

  def deduct(money)
    @balance -= money
  end

  def charge_penalty_fare
    @current_journey.end(nil)
    deduct(@current_journey.fare)  # @balance -= @current_journey[:fare]
  end

end
