require 'station'

describe Station do

  subject {described_class.new("Wimbledon", 3)}

  it 'has a name' do
    expect(subject.name).to eq "Wimbledon"
  end

  it 'has a zone' do
    expect(subject.zone).to eq 3
  end

end
