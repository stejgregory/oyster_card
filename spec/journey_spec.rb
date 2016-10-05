require 'journey'

describe Journey do
  let(:station) { double :station, zone: 1}

  describe '#initialize' do
    it 'sets entry station to equal nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'sets exit_station to equal nil' do
      expect(subject.exit_station).to eq nil
    end

    it 'has an empty current journey' do
      expect(subject.current_journey).to be_empty
    end
  end

  describe '#finish' do
    it 'it is set to exit_station' do
      expect(subject.finish(station)).to eq(station)
    end
  end

  describe '#fare' do
    it 'has a penalty fare by default' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  context 'give an exit station' do
  let(:exit_station) {double :exit_station}

  before do
    subject.finish(exit_station)
  end

    it 'calculates a fare' do
      expect(subject.fare).to eq 1
    end
  end



# starting a journey

# finishing a journey

# calculation the fair of a journey

# returning wether or not the journey is complete

end
