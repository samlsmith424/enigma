class Enigma
  attr_reader :character_set,
              :number_key

  def initialize(key = nil)
    @character_set = ("a".."z").to_a << " "
    @number_key = key || make_number_key

  end

  def make_number_key
    5.times.map{rand(10)}.join
  end

  def key_shift(key)
    numbers = []
    numbers << key[0..1].to_i
    numbers << key[1..2].to_i
    numbers << key[2..3].to_i
    numbers << key[3..4].to_i
    numbers
  end

  def current_date
    # Time.now.strftime("%d/%m/%y").gsub('/', "")
    Date.today.strftime("%d%m%y")
  end

  def offset_shift
    # shift = current_date.to_i ** 2
    shift = date.to_i ** 2
    shift.to_s[-4..-1].split('').map(&:to_i)
  end

  def final_shift
    keys = key_shift(number_key)
    offsets = offset_shift
    shifts = []
    shifts << keys[0] + offsets[0]
    shifts << keys[1] + offsets[1]
    shifts << keys[2] + offsets[2]
    shifts << keys[3] + offsets[3]
    shifts
  end

  def encrypt(string, key, date = current_date)
    hash = {:encryption => "", :key => key, :date => date}
    letters = string.split(//)
    letters.each_with_index do |character, index|
      if index % 4 == 0
        hash[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift[0]) % 27))
      elsif index % 4 == 1
        hash[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift[1]) % 27))
      elsif index % 4 == 2
        hash[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift[2]) % 27))
      elsif index % 4 == 3
        hash[:encryption] += @character_set.fetch(((@character_set.index(character) + final_shift[3]) % 27))
        # require "pry"; binding.pry
      end
    end
    hash
  end
end
