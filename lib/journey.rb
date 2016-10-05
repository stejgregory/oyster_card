class Journey

  attr_reader :entry_station, :exit_station

  def initialize(entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
  end

  def start(entry_s)
    @entry_station = entry_s
  end

  def end(exit_s)
    @exit_station = exit_s
    return {entry_station: @entry_station, exit_station: @exit_station}
    @entry_station = nil
    @exit_station = nil
  end

  def complete?
    if @entry_station.nil?
      false
    else
      !@exit_station.nil?
    end
  end
end
