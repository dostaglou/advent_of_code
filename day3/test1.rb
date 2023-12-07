require_relative '../file_manager'

INTEGERS = %w(1 2 3 4 5 6 7 8 9 0)
EXCLUDE_CHARS = %w(1 2 3 4 5 6 7 8 9 0 .)
LINE_LENGTH = 140

# Does not arrive at correct solution
class Solver
  attr_accessor :data_array, :string, :valids
  def initialize(data)
    @data_array = data
    @string = data.join
    @valids = []
  end

  def solve
    valid_numbers = []
    current_number = ""
    current_number_counted = false
    last = string.length - 1

    string.each_char.with_index do |char, index|
      if INTEGERS.include?(char)
        current_number << char
        current_number_counted = true if will_count?(index)
      elsif current_number != "" || index == last
        valid_numbers << current_number.to_i if current_number_counted
        current_number = ""
        current_number_counted = false
      end
    end

    @valids = valid_numbers
    valid_numbers.sum
  end

  def will_count?(current_location)
    str = ""
    str << range_content(current_location)
    str << range_content(current_location + LINE_LENGTH)
    str << range_content(current_location - LINE_LENGTH)

    str.split("").reject {|c| EXCLUDE_CHARS.include?(c) }.size > 0
  end

  def range_content(location)
    range = (location - 1..location + 1).reject { |x| x < 0 }

    return "" if range.empty?

    string[range[0]..range[-1]].to_s
  end
end
