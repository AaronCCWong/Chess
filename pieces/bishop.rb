require_relative '../sliding_piece'

class Bishop < SlidingPiece
  OFFSET = [
    [1, 1],
    [1,-1],
    [-1, 1],
    [-1, -1]
  ]

  def enter_board
    set_position(color, [7, 2])
  end

  def to_s
    "\u2657".colorize(color)
  end
end
