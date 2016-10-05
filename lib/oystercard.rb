
require_relative 'journey'

class Oystercard

  attr_reader :balance

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @journey_log = []
  end

  def top_up(money)
    fail "Beyond limit of #{MAXIMUM_BALANCE}" if (balance + money) > MAXIMUM_BALANCE
    @balance += money
  end

  def in_journey?
    if @current_journey.nil?
      false
    else
      @current_journey.complete?
    end
    # if @journey_log.empty?
    #   false
    # else

      # @journeys.last.exit_station.nil?
    # end
  end

  def touch_in(entry_s)
    fail "Insufficient balance" if balance < MINIMUM_FARE
    @current_journey = Journey.new
    @current_journey.start(entry_s)
    # @journeys << Journey.new(entry_station = entry_s, exit_station = nil)
  end

  def touch_out(exit_s)
    deduct(MINIMUM_FARE)
     @journey_log << @current_journey.end(exit_s)
     @current_journey = nil
    # if in_journey?
    #   @journey_log << @journeys.end(exit_s)
    #   # @journeys.last.exit_station = exit_s
    # else
    #   @journey_log << Journey.new(entry_station = nil, exit_station = exit_s)
    # end
  end

  def journey_history
    @journeys
  end

  private

  def deduct(money)
    @balance -= money
  end

end
