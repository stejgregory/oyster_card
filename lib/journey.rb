class Journey
require_relative 'oystercard'

attr_reader :entry_station, :exit_station

PENALTY_FARE = 6
DEFAULT_ENTRY = nil
DEFAULT_EXIT = nil

  def initialize(station = DEFAULT_ENTRY)
    @entry_station = station
  end

  def finish(station = DEFAULT_EXIT)
    @exit_station = station
  end



  def complete?
    !!@entry_station && !!@exit_station
  end


  def fare
      if complete? == true
      Oystercard::MINIMUM_FARE
      else
      PENALTY_FARE
      end
  end

end
