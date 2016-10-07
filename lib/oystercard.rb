
require_relative 'journey'
require_relative 'journey_log'

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
    double_touch_in if @current_journey # (!@journey_log.empty? && !@journey_log.last.complete?)
    # charge_penalty_fare(nil) if @current_journey # (!@journey_log.empty? && !@journey_log.last.complete?) ##CHANGE ME
    @current_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)
    double_touch_out(exit_station) if !@current_journey
    end_current_journey(exit_station)
  end

  def journey_history
    @journey_log
  end

  private

  def deduct(money)
    @balance -= money
  end


  def double_touch_out exit_station
    @current_journey = Journey.new
  end


  def double_touch_in
    end_current_journey(nil)
  end

  def end_current_journey(exit_station)
    @journey_log << @current_journey.end(exit_station)
    deduct(@current_journey.fare)
    @current_journey = nil
  end
end
