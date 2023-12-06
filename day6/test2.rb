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
    @data = parse_data(data)
  end

  def solve
    range = 1...data[:time]

    lowest_num = range.find do |num|
      (data[:time] - num) * num > data[:distance]
    end

    (lowest_num..data[:time] - lowest_num).size
  end

  def parse_data(data)
    time = ""
    distance = ""
    data.each do |datum|
      time << datum[:time].to_s
      distance << datum[:distance].to_s
    end

    { time: time.to_i, distance: distance.to_i }
  end
end

# s = Solver.new(DATA)
# s.solve
