require 'oystercard'

describe Oystercard do

  it 'balance is zero' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do
      expect{ subject.top_up 1}.to change{ subject.balance }.by 1
    end

    it 'can not be topped up beyond limit' do
      message = "Beyond limit of #{described_class::MAXIMUM_BALANCE}"
      subject.top_up(described_class::MAXIMUM_BALANCE)
      expect {subject.top_up(1)}.to raise_error message
    end

  end

  describe '#deduct' do
    it { is_expected.to respond_to(:deduct).with(1).argument }

    it 'can deduct the balance' do
      subject.top_up 5
      expect{ subject.deduct 2}.to change{ subject.balance }.by -2
    end
  end

  describe '#in_journey?' do
    it { is_expected.to respond_to(:in_journey?) }

    it 'new card not in_journey' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'changes in_journey to true' do
      subject.touch_in
      expect(subject).to be_in_journey
    end
  end

  describe '#touch_out' do
    it 'changes in_journey to false' do
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end
  end





end
