require 'oyster_card'

describe Oystercard do
  # let(:oyster_card) { double :Oystercard.new }
  it { is_expected.to respond_to :check_balance}

  it "checks that opening balance = 0" do
  expect(Oystercard::DEFAULT_BALANCE).to eq(0)
  end

  it "checks that a newly created card has a balance of 0" do
    card = Oystercard.new
    expect(card.check_balance).to eq 0
  end

  it "tops up the card with additional funds, and increases the balance by that amount" do
    card = Oystercard.new
    card.topup(10)
    expect(card.check_balance).to eq 10
  end

  # it "sets a maximum topup limit of 90 pounds sterling" do
  #   card = Oystercard.new
  #   card.topup(90)
  #   expect(card.topup(1)).to eq "Error, this will exceed the £90 maximum balance."
  # end

end
