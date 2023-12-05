require_relative '../file_manager'

class Solver
  attr_accessor :data, :mappers, :seeds

  def initialize(data_array)
    @seeds = []
    @data = parse_data(data_array)
    @mappers = {}
    build_mappers
  end

  def solve
    locations = @seeds.map { |x| seed_to_location(x) }
    locations.min
  end

  def seed_to_location(seed)
    set_keys = @mappers.keys
    step_value = seed
    set_keys.each do |key|
      step_value = transver_map(step_value, @mappers[key])
    end

    step_value
  end

  def transver_map(starting_number, data_sets)
    mapped_set = data_sets.find { |set| set[:source] + set[:range] >= starting_number && starting_number >= set[:source] }
    if mapped_set
      mapped_set[:destination] + starting_number - mapped_set[:source]
    else
      starting_number
    end
  end

  def parse_data(data_array)
    data_array.reject! { |x| x == "" }
    @seeds = data_array.shift.split(":")[1].split(" ").map(&:to_i)
    data_array
  end

  def build_mappers
    current_title = ""

    @data.each do |row|
      if row.include?("map:")
        name = row.gsub(" map:", "")
        @mappers[name] = []
        current_title = name
      else
        info = row.split(" ")
        @mappers[current_title] << { destination: info[0].to_i, source: info[1].to_i, range: info[2].to_i }
      end
    end
  end
end

# Solver.new(DATA).solve
