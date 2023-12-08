require_relative '../file_manager'

LETTER_TO_INT = { "L"=> 0, "R"=> 1 }

class Solver
  attr_accessor :nodes, :instruction, :data

  def initialize(data)
    @data = data
    set_instructions_nodes
    @step = 0
    @solved = false
    @current_point = "AAA"
  end

  def set_instructions_nodes
    @instruction = @data.shift.split("").map { |i| LETTER_TO_INT[i] }

    @data.reject!{ |node| node.empty? }
    @nodes = @data.each_with_object({}) do |line, hsh|
      split = line.split(" = ")
      node = split[0]
      v = split[1].gsub("(", "").gsub(")", "").split(", ")
      hsh[node] = v
    end
  end

  def solve
    until @solved
      @instruction.each_with_index do |action|
        @step += 1
        value = @nodes[@current_point][action]
        if value == "ZZZ"
          @solved = true
          break
        else
          @current_point = value
        end
      end
    end

    @step
  end
end


