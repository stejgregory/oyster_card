require 'oystercard'

describe Oystercard do

  let(:entry_station) {double(:station)}
  let(:exit_station) {double(:station)}
  let(:journey) {double(:journey)} #{ {entry_station: entry_station, exit_station: exit_station} }

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

  describe '#touch_in' do

    it 'raises error when insufficient balance' do
      expect{subject.touch_in(entry_station)}.to raise_error "Insufficient balance"
    end

    it 'creates new journey' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      expect(subject.journey_history[-1].entry_station).to eq(entry_station)
    end

    it 'if user touches in twice, end previous journey' do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_in(double(:station))
      expect(subject.journey_history[-2].exit_station).to eq(nil)
    end
  end

  describe '#touch_out' do

    before do
      subject.top_up(described_class::MAXIMUM_BALANCE)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end

    it 'deducts the correct amount from card' do
      expect{ subject.touch_out(exit_station) }.to change{ subject.balance }.by (-described_class::MINIMUM_FARE)
    end

    it 'allows you to touch out without touching in and saves second station' do
      second_touch_out = double(:station)
      subject.touch_out(second_touch_out)
      expect(subject.journey_history[-1].exit_station).to eq(second_touch_out)
    end

    it 'allows you to touch out twice with nil entry station' do
      subject.touch_out(double(:station))
      expect(subject.journey_history[-1].entry_station).to eq nil
    end
  end

  describe '#initialize' do
    it 'has empty list of journeys' do
      expect(subject.journey_history).to be_empty
    end

    it 'balance is zero' do
      expect(subject.balance).to eq(0)
    end
  end

end
