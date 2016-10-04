require 'oystercard'

describe Oystercard do

  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}

  it 'balance is zero' do
    expect(subject.balance).to eq(0)
  end

  context 'With max balance on card' do
    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
    end

    it 'can not be topped up beyond limit' do
      message = "Beyond limit of #{described_class::MAXIMUM_BALANCE}"
      expect{subject.top_up(1)}.to raise_error message
    end
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it 'new card not in_journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do

    it 'raises error when insufficient balance' do
      expect{subject.touch_in(entry_station)}.to raise_error "Insufficient balance"
    end

    it 'changes in_journey to true' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it 'stores entry station' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do

    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end

    # This is problematic because we're touching out twice and no error is raised
    it 'deducts the correct amount from card' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by (-described_class::MINIMUM_FARE)
    end

    it 'changes in_journey to false' do
      expect(subject).not_to be_in_journey
    end

    it 'sets entry station to nil' do
      expect(subject.entry_station).to eq nil
    end

    it 'stores exit station' do
      expect(subject.exit_station).to eq exit_station
    end
  end

  describe '#journey_history' do
    it 'returns entry and exit station' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      journey = { entry_station: entry_station, exit_station: exit_station }
      expect(subject.journey_history).to eq [journey]
    end
  end

end
