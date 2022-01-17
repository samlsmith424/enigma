require 'date'

module Helpable
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
    Date.today.strftime("%d%m%y")
  end

  def offset_shift(date)
    shift = date.to_i ** 2
    shift.to_s[-4..-1].split('').map(&:to_i)
  end

  def final_shift(number_key, date_key)
    keys = key_shift(number_key)
    offsets = offset_shift(date_key)
    shifts = []
    shifts << keys[0] + offsets[0]
    shifts << keys[1] + offsets[1]
    shifts << keys[2] + offsets[2]
    shifts << keys[3] + offsets[3]
    shifts
  end
end
