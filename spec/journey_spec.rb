require 'journey'
require 'oystercard'

describe Journey do
  subject{described_class.new(entry_station)}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}

  it 'A journey has started' do
    expect(subject.entry_station).to eq entry_station
  end

    it 'sets exit_station to equal nil' do
      expect(subject.exit_station).to eq nil
    end


  describe '#complete?' do
    it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
    end
  end

    it 'knows if a journey is complete' do
      subject.finish(exit_station)
      expect(subject).to be_complete
    end

  describe '#fare' do
    it 'has a penalty fare by default' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end

  it 'calculates a fare' do
      subject.finish(exit_station)
      expect(subject.fare).to eq Oystercard::MINIMUM_FARE
    end

    it "knows if a journey is complete" do
      subject.finish(exit_station)
    expect(subject).to be_complete
  end
end



# starting a journey

# finishing a journey

# calculation the fair of a journey

# returning wether or not the journey is complete
