require_relative './test1'

class Hand2 < Hand
  def parse_hand(input)
    x = super(input)
    x.map { |x|  x == 11 ? 1 : x }
  end

  def determine_hand_strength
    without_wilds = hand.select { |x| x != 1 }
    wild_count = 5 - without_wilds.size
    grouping = without_wilds.group_by(&:itself)
    max_group = 0
    grouping.each { |k, v| max_group = v.size if max_group < v.size }

    case
    when grouping.size <= 1
      HAND_POWER_MAP[:five]
    when grouping.size == 2 && (max_group + wild_count) == 4
      HAND_POWER_MAP[:four]
    when grouping.size == 2 && (max_group + wild_count) == 3
      HAND_POWER_MAP[:full]
    when grouping.size == 3 && (max_group + wild_count) == 3
      HAND_POWER_MAP[:three]
    when grouping.size == 3 && (max_group + wild_count) == 2
      HAND_POWER_MAP[:two_pair]
    when grouping.size == 4 && (max_group + wild_count) == 2
      HAND_POWER_MAP[:pair]
    else
      HAND_POWER_MAP[:single]
    end
  end
end


class Solver2 < Solver
  def data_to_hands(data)
    data.map { |d| Hand2.new(d) }
  end
end
