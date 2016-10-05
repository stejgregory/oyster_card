# require 'station'

class Journey
DEFAULT_FARE = 6

attr_reader :entry_station, :exit_station, :current_journey

  def initialize(*entry_station)
    @entry_station = nil
    @exit_station = nil
    @current_journey = Hash.new
  end

  def finish(station)
    @exit_station = station
  end

  def fare(fare = DEFAULT_FARE)
    if @entry_station == nil || @exit_station == nil
      DEFAULT_FARE
    else
      fare = 1
  end

end
