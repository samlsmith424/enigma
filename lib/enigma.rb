class Enigma
  attr_reader :character_set

  def initialize
    @character_set = ("a".."z").to_a << " "
  end

  def make_number_key
    5.times.map{rand(10)}.join
  end

  def key_shift(number)
    numbers = []
    numbers << number[0..1].to_i
    numbers << number[1..2].to_i
    numbers << number[2..3].to_i
    numbers << number[3..4].to_i
    numbers
  end

  def current_date
    Time.now.strftime("%d/%m/%y").gsub('/', "")
  end

  def offset_shift(date)
    shift = current_date.to_i ** 2
    shift.to_s[-4..-1].split('').map(&:to_i)
  end

  def final_shift(keys, offsets)
    shifts = []
    shifts << keys[0] + offsets[0]
    shifts << keys[1] + offsets[1]
    shifts << keys[2] + offsets[2]
    shifts << keys[3] + offsets[3]
    shifts
  end
end
