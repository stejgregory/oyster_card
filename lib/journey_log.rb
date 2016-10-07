require 'Journey'

class JourneyLog

  def initialize
    @journey_class = journey_class
    @journeys = []
  end

  def start(entry_station)
    @thisjourney = Journey.new(entry_station)
  end

  def stop(exit_station)
    @journeys << @thisjourney.end(exit_station)
  end
end
