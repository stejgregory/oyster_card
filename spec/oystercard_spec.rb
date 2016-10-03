require 'oystercard'

describe Oystercard do
  subject(:oystercard) {described_class.new}

  it { is_expected.to respond_to :balance }

  describe 'initialization' do
    it 'has a default balance of 0' do
      expect(subject.balance).to eq 0
    end
  end

  it 'allows a user to top-up their oystercard' do
    card = Oystercard.new
    card.top_up(40)
    expect(card.balance).to eq 40
  end

  it 'will raise an error if maximum card value is reached' do
    maximum_balance = described_class::MAXIMUM_BALANCE
    card = Oystercard.new
    card.top_up(maximum_balance)
    message = "Card limit of £#{maximum_balance} has been reached."
    expect{ card.top_up(1) }.to raise_error message
  end
end
