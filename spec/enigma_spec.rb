require 'date'
require './lib/enigma'

RSpec.describe Enigma do
  let(:enigma) {Enigma.new}

  it 'exists' do
    expect(enigma).to be_a(Enigma)
  end

  it 'can generate a random five digit number key' do
    expect(enigma.make_number_key).to be_a(String)
  end

  it 'has a character set' do
    expected = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "]
    expect(enigma.character_set).to eq(expected)
  end

  it 'can generate keys from five digit number' do
    expect(enigma.key_shift("02715")).to eq([02, 27, 71, 15])
  end
end
