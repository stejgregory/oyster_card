require 'journey'

describe Journey do

  describe '#initialize' do

    it 'has a default entry_station of nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'has a default exit_station of nil' do
      expect(subject.exit_station).to eq nil
    end

  end

end
