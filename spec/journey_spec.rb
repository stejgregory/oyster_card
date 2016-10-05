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

    it "knows if a journey is not complete" do
      expect(subject).not_to be_complete
 end

    context 'given an entry station' do
      subject {described_class.new(entry_station = "station")}

      it 'has an entry station' do
       expect(subject.entry_station).to eq "station"
     end

      context 'given an exit station' do

        before do
          subject.end("other_station")
        end

        it "knows if a journey is complete" do
          expect(subject).to be_complete
        end

      end
    end

end
