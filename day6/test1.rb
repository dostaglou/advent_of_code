TEST_DATA = [
  { time: 7, distance: 9 },
  { time: 15, distance: 40 },
  { time: 30, distance: 200 },
]
DATA = [
  { time: 47, distance: 207 },
  { time: 84, distance: 1394 },
  { time: 74, distance: 1209 },
  { time: 67, distance: 1014 },
]

class Solver
  attr_accessor :data
  def initialize(data)
    @data = data
  end

  def solve
    data.map { |stats| winning_options(stats) }.inject(&:*)
  end

  def winning_options(stats)
    range = 1...stats[:time]

    lowest_num = range.find do |num|
      (stats[:time] - num) * num > stats[:distance]
    end

    (lowest_num..stats[:time] - lowest_num).size
  end
end

# s = Solver.new(DATA)
# s.solve
