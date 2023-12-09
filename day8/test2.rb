require_relative './test1'

class Solver2 < Solver
  def determine_starting_point
    @current_points = @nodes.keys.select { |node| node.end_with?('A') }
  end

  def valid_finish?(value)
    value.end_with?("Z")
  end
end
