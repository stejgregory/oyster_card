require 'oyster_card'

describe Oystercard do
  let(:card) { (Oystercard.new) }
  it { is_expected.to respond_to :check_balance}

  it "checks that opening balance = 0" do
  expect(Oystercard::DEFAULT_BALANCE).to eq(0)
  end

  it "checks that a newly created card has a balance of 0" do
    expect(card.check_balance).to eq 0
  end

  it "tops up the card with additional funds, and increases the balance by that amount" do
    card.topup(10)
    expect(card.check_balance).to eq 10
  end

  it "sets a maximum topup limit of 90 pounds sterling" do
    card.topup(90)
    expect(card.topup(1)).to eq "Error, this will exceed the £90 maximum balance."
  end

  it "will reduce the card's balance when money is withdrawn or used" do
    card.topup(45)
    card.deduct(10)
    expect(card.check_balance).to eq(35)
  end

  it "will know when the card has been used to touch-in" do
    expect(card.touch_in?).to eq true
  end

  it "will know when the card has been used to touch-out" do
    expect(card.touch_out?).to eq false
  end

  it "will know when the card is in journey" do
    card.touch_in?
    expect(card.in_journey?).to eq true
  end

end
