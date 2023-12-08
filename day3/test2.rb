require_relative '../file_manager'

INTEGERS = %w(1 2 3 4 5 6 7 8 9 0)
LINE_LENGTH = 140

class Solver
  attr_accessor :data_array, :string, :valids
  def initialize(data)
    @data_array = data
    @string = data.join
    @valids = []
  end

  def solve
    valid_numbers = []

    string.each_char.with_index do |char, index|
      next unless char == "*"
      prior = string[index-3..index].match(/\d/)
      post = string[index..index+2].match(/\d/)
    end
  end

  def range_content(location)
    range = (location - 1..location + 1).reject { |x| x < 0 }

    return "" if range.empty?

    string[range[0]..range[-1]].to_s
  end
end
