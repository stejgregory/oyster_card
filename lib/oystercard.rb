
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
    double_touch_in(entry_station) if @current_journey # (!@journey_log.empty? && !@journey_log.last.complete?)
    # charge_penalty_fare(nil) if @current_journey # (!@journey_log.empty? && !@journey_log.last.complete?) ##CHANGE ME
    @current_journey = Journey.new(entry_station)
  end

  def touch_out(exit_station)



    if !@current_journey #(!@journey_log.empty? && !@current_journey)
      double_touch_out

      charge_penalty_fare(exit_station) # if (!@journey_log.empty? && !@current_journey)


    else
      end_current_journey(exit_station)
    end


    @current_journey.end(exit_station)
    deduct(@current_journey.fare)
    @current_journey = nil
  end

  def journey_history
    @journey_log
  end

  private

  def deduct(money)
    @balance -= money
  end


  def double_touch_out
    @current_journey = Journey.new
    deduct(@current_journey.fare)
    end_current_journey(exit_station)

  end


  def double_touch_in
    deduct(PENALTY_FARE)
    end_current_journey(nil) #double touch in
  end


  # def charge_penalty_fare(exit_station)
  #   if @current_journey
  #
  #   elsif !@current_journey #double touch out
  #     @current_journey = Journey.new
  #     end_current_journey(exit_station)
  #   end
  #   # @balance -= @current_journey[:fare]
  # end

  # def end_current_journey(exit_station)
  #   @current_journey.end(exit_station)
  #   deduct(@current_journey.fare)
  #   @current_journey = nil
  # end
end
