class Journey

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil)
    @entry_station = entry_station
    @complete = false
  end

  def end(exit_station)
    @exit_station = exit_station
    @complete = true
    fare
    self
  end

  def complete?
      @complete
  end

  def fare
    if @entry_station == nil || @exit_station == nil
      Oystercard::PENALTY_FARE
    else
      Oystercard::MINIMUM_FARE
    end
  end
end
