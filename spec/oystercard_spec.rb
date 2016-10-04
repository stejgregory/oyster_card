require 'oyster_card'

describe Oystercard do
  let(:card) { (Oystercard.new) }
  it { is_expected.to respond_to :check_balance}

  it "should have an opening balance = 0" do
    expect(Oystercard::DEFAULT_BALANCE).to eq(0)
  end


  describe '#in_journey'  do
    it "will know when the card is in journey" do
      card.topup(1.0)
      card.touch_in?
      expect(card.in_journey?).to eq true
    end

  end


  describe '#touch_in' do
    it "will know when the card has been used to touch-in" do
      card.topup(1.0)
      expect(card.touch_in?).to eq true
    end

    it "will onll allow a card to touch_in if it has a balance >= £1" do
      card.topup(0.5)
      expect(card.touch_in?).to eq "Not enough funds on card."
    end

  end


  describe '#touch_out' do

    it "will know when the card has been used to touch-out" do
      expect(card.touch_out?).to eq false
    end

  end


  describe '#top_up' do

    it "tops up the card with additional funds, and increases the balance by that amount" do
      card.topup(10)
      expect(card.check_balance).to eq 10
    end

    it "sets a maximum topup limit of 90 pounds sterling" do
      card.topup(90)
      expect(card.topup(1)).to eq "Error, this will exceed the £90 maximum balance."
    end
  end
end
