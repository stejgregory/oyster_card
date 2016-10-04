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

  it 'allows a fare to be deducted from their oystercard' do
    subject.top_up(described_class::MAXIMUM_BALANCE)
    subject.deduct(described_class::MAXIMUM_BALANCE)
    expect(subject.balance).to eq 0
  end

  describe '#in_journey?' do
    it 'will be initially set to false' do
      expect(subject.in_journey).to eq false
    end
  end

  it 'will raise error if balance is less than minimum fare' do
    expect{ subject.touch_in }.to raise_error "Insufficient funds"

  end

  context 'using a card' do
    before do
      subject.top_up(described_class::MINIMUM_BALANCE)
      subject.touch_in
    end
    describe '#touch_in' do
      it 'will set #in_journey? to true' do
        expect(subject.in_journey).to eq true
      end

    end

    describe '#touch_out' do
      it 'will set #in_journey? to false' do
        subject.touch_out
        expect(subject.in_journey).to eq false
      end
    end
  end
end
