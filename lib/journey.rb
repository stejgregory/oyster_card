# require 'station'

class Journey
PENALTY_FARE = 6

attr_reader :entry_station, :exit_station, :current_journey

  def initialize(*entry_station)
    @entry_station = nil
    @exit_station = nil
    @current_journey = Hash.new
  end

  def finish(station)
    @exit_station = station
  end

  def start(station)
    @entry_station = station
  end

  def complete?
    !!exit_station
  end


  def fare(fare = PENALTY_FARE)
      if @entry_station == nil || @exit_station == nil
      return PENALTY_FARE
      else
      fare = 1
      end
  end

end
