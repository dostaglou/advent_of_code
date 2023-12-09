require_relative '../file_manager'

LETTER_TO_INT = { "L"=> 0, "R"=> 1 }

class Solver
  attr_accessor :nodes, :instruction, :data, :current_points, :new_nodes

  def initialize(data)
    @growth = 0
    @step = 0
    @current_points = []
    @solved = false
    @data = data
    set_instructions_nodes
    process_nodes
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

    determine_starting_point
  end

  def process_nodes
    @new_nodes = {}

    @nodes.each do |key, value|
      @current_value = key
      @new_nodes[key] = { seq: [], finish: nil, og: value, solution_points: [] }

      seq = @instruction.each do |i| # 0 | 1
        new_value = @nodes.dig(@current_value, i)
        @new_nodes[key][:seq] << valid_finish?(new_value)
        @current_value = new_value
      end

      @new_nodes[key][:solution_points] = @new_nodes[key][:seq].map.with_index {|v, i| i if v }.compact
      @new_nodes[key][:finish] = @current_value
    end

    @new_nodes
  end

  def valid_finish?(value)
    value == "ZZZ"
  end

  def determine_starting_point
    @current_points = @nodes.keys.select { |node| node == "AAA" }
  end

  def solve
    time = Time.now
    until @solved
      starts = @new_nodes.slice(*@current_points)

      sps = []
      finishes = []

      starts.each do |k, v|
        finishes << v[:finish]
        sps << v[:solution_points]
      end

      shared_points = sps.reduce(&:&)
      if !shared_points.empty?
        @solved = true
        @step += (1+shared_points[0])
      else
        @step += instruction.size
        @growth += instruction.size
        @current_points = finishes
      end

      if @growth > 10_000_000
        puts "RUN! #{@step}"
        @growth = 0
      end
    end

    p [time, Time.now]
    @step
  end
end
