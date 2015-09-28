require_relative '../sliding_piece'

class Rook < SlidingPiece
  OFFSET = [
    [1,0],
    [-1, 0],
    [0, 1],
    [0, -1]
  ]

  def enter_board
    set_position(color, [7, 0])
  end

  def to_s
    "\u2656".colorize(color)
  end
end
