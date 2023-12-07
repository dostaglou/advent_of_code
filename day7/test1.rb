require_relative '../file_manager'

CARD_TO_POINT_MAP = {
  "A" => 14,
  "K" => 13,
  "Q" => 12,
  "J" => 11,
  "T" => 10,
  "9" => 9,
  "8" => 8,
  "7" => 7,
  "6" => 6,
  "5" => 5,
  "4" => 4,
  "3" => 3,
  "2" => 2,
}

HAND_POWER_MAP = {
  five: 7,
  four: 6,
  full: 5,
  three: 4,
  two_pair: 3,
  pair: 2,
  single: 1
}


class Hand
  attr_accessor :hand, :bid, :strength

  def initialize(input)
    @hand = parse_hand(input)
    @bid = parse_bid(input)
    @strength = determine_hand_strength
  end

  def parse_bid(input)
    input.split(" ")[1].to_i
  end

  def parse_hand(input)
    input.split("")[0..4].map { |x| CARD_TO_POINT_MAP[x] }
  end

  def determine_hand_strength
    grouping = hand.group_by(&:itself)
    max_group = 0
    grouping.each { |k, v| max_group = v.size if max_group < v.size }

    case
    when grouping.size == 1
      HAND_POWER_MAP[:five]
    when grouping.size == 2 && max_group == 4
      HAND_POWER_MAP[:four]
    when grouping.size == 2 && max_group == 3
      HAND_POWER_MAP[:full]
    when grouping.size == 3 && max_group == 3
      HAND_POWER_MAP[:three]
    when grouping.size == 3 && max_group == 2
      HAND_POWER_MAP[:two_pair]
    when grouping.size == 4
      HAND_POWER_MAP[:pair]
    else
      HAND_POWER_MAP[:single]
    end
  end
end

class Solver
  attr_accessor :hands
  def initialize(data)
    @hands = data_to_hands(data)
  end

  def data_to_hands(data)
    data.map { |d| Hand.new(d) }
  end

  def solve
    sort_hands.map.with_index(1) { |h, rank| h.bid * rank }.sum
  end

  def sort_hands
    self.hands.sort_by do |h|
      [h.strength, h.hand[0], h.hand[1], h.hand[2], h.hand[3], h.hand[4]]
    end
  end
end

# s = Solver.new(FileManager.new("day7").stripped_data("text.txt"))
# s.solve
