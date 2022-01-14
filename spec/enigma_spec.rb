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

  it 'can generate the current date' do
    allow(Date).to receive(:today).and_return(Date.new(2022, 01, 13))
    expect(enigma.current_date).to eq("130122")
  end

  it 'can make offsets from the current date' do
    allow(Date).to receive(:today).and_return(Date.new(2022, 01, 13))
    expect(enigma.offset_shift("130122")).to eq([4, 8, 8, 4])
  end

  it 'can make a final shift from adding the key and offset shifts' do
    # enigma_with_key = Enigma.new("02715")
    # expect(enigma_with_key.final_shift).to eq([6, 35, 79, 19])
    # expect(enigma_with_key.final_shift).to eq([3, 27, 73, 20])
    # expect(enigma.final_shift([02, 27, 71, 15], [1, 0, 2, 5])).to eq([3, 27, 73, 20])
    expect(enigma.final_shift("02715", "040895")).to eq([3, 27, 73, 20])
  end

  it 'can encrypt a string' do
    expected = {
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
    }
    expect(enigma.encrypt("hello world", "02715", "040895")).to eq(expected)
  end

  it 'can encrypt a string with punctuation' do
    expected = {
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895"
    }
    expect(enigma.encrypt("Hello world!", "02715", "040895")).to eq(expected)
  end

  it 'can encrypt a different string with punctuation' do
    expected = {
      encryption: "mzzvmkvob",
      key: "12345",
      date: "081292"
    }
    expect(enigma.encrypt("sam smith", "12345", "081292")).to eq(expected)
  end

  it 'can encrypt a string with an a random key generated' do
    expect(enigma.encrypt("hello world", "040895")).to be_a(Hash)
  end

  it 'can encrypt a string with a todays date generated' do
    expect(enigma.encrypt("hello world", "02715")).to be_a(Hash)
  end

  it 'can encrypt a string with generated key and date' do
    expect(enigma.encrypt("hello world")).to be_a(Hash)
  end

  it 'can decrypt a string' do
    expected = {
      decryption: "hello world",
      key: "02715",
      date: "040895"
    }

    expected_2 = {
      decryption: "sam smith",
      key: "12345",
      date: "081292"
    }
    expect(enigma.decrypt("keder ohulw", "02715", "040895")).to eq(expected)
    expect(enigma.decrypt("mzzvmkvob", "12345", "081292")).to eq(expected_2)
  end

  it 'can decrypt a string with todays date generated' do
    encrypted = enigma.encrypt("hello world", "02715")
    expect(enigma.decrypt(encrypted[:encryption], "02715")).to be_a(Hash)
  end
end
