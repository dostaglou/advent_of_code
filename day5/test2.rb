require_relative './test1'

# This will solve the second problem if given a strong enough machine but the ruby code is too slow and memory intensive for my machine.

class Solver2 < Solver
  SLICE_CAP = 1_000_000
  def set_seeds!(data_array)
    starting_array = data_array.shift.split(":")[1].split(" ").map(&:to_i)
    sub_array = []
    starting_array.each_slice(2) do |s|
      top = s[0] + s[1]
      sub_array << (s[0]...top)
    end

    @seeds = sub_array
  end

  def solve
    seeds.each.with_index(1) do |seed_set, index|
      seed_set.each_slice(SLICE_CAP) do |slice_set|
        slice_set.each_with_index do |seed, sub_index|
          seed_to_location(seed)
        end
      end
    end

    lowest_location
  end
end
