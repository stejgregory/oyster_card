require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  describe 'initialization' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  context 'top-up card' do
    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
    end
    it 'allows a user to top-up their oystercard' do
      expect(subject.balance).to eq described_class::MAXIMUM_BALANCE
    end

    it 'will raise an error if maximum card value is reached' do
      message = "Card limit of £#{described_class::MAXIMUM_BALANCE} has been reached."
      expect{ subject.top_up(described_class::MINIMUM_BALANCE) }.to raise_error message
    end
  end

  describe '#in_journey?' do
    it 'will be initially set to false' do
      expect(subject.in_journey?).to eq false
    end
  end

  it 'will raise error if balance is less than minimum fare' do
    #allow(subject).to receive(:entry_station)
    expect{ subject.touch_in(:entry_station) }.to raise_error "Insufficient funds"

  end

  context 'using a card' do
    before do
      subject.top_up(described_class::MINIMUM_BALANCE)
      subject.touch_in(:entry_station)
      subject.touch_out(:exit_station)
    end
    describe '#touch_in' do
      it 'will set #in_journey? to true' do
        expect(subject.in_journey?).to eq true
      end
      it "will set station to entry station" do
        expect(subject.entry_station).to eq :entry_station
      end

    end
    describe '#touch_out' do
      #it 'will set #in_journey? to false' do
      #  subject.touch_out(:exit_station)
      #  expect(subject.in_journey?).to eq false
      #end
      it 'will reduce balance by minimum fare' do
        expect {subject.touch_out(:exit_station)}.to change {subject.balance}.by(-described_class::MINIMUM_FARE)
      end
    #  it 'will reset the entry station on exit' do
    #    subject.add_journey(:entry_station)
    #    expect(subject.add_journey(:entry_station)).to eq false
    #  end
      it 'will add the journey to the journeys list' do
        subject.add_journey
        expect {subject.add_journey}.to eq @current_journey
      end
    end
  end





end
