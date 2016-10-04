require 'oyster_card'

describe Oystercard do
  let(:card) { (Oystercard.new) }

  it "should have an opening balance = 0" do
    expect(Oystercard::DEFAULT_BALANCE).to eq(0)
  end



  describe '#in_journey'  do
    it "will know when the card is in journey" do
      card.topup(1.0)
      card.touch_in
      expect(card.in_journey?).to eq true
    end

  end


  describe '#touch_in' do

    it "will change the in_journey status to true" do
      card.topup(described_class::MAX_BALANCE)
      card.touch_in
      expect(card).to be_in_journey
    end

    it "will only allow a card to touch_in if there are sufficent funds" do
      expect{ card.touch_in }.to raise_error "Not enough funds on card."
    end

  end


  describe '#touch_out' do

    it "will change the in_journey status to false" do
      card.topup(described_class::MAX_BALANCE)
      card.touch_in
      card.touch_out
      expect(card).not_to be_in_journey
    end

  end

  describe '#topup' do

    it "tops up the card with additional funds, and increases the balance by that amount" do
      expect{ card.topup(10) }.to change{ card.balance }.by(10)
    end

    it "sets a maximum topup limit of 90 pounds sterling" do
      card.topup(described_class::MAX_BALANCE)
      expect{ card.topup(1) }.to raise_error "Error, this will exceed the £#{described_class::MAX_BALANCE} maximum balance."
    end
  end
end
