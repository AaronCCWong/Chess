require_relative '../stepping_piece'

class Knight < SteppingPiece
  OFFSET = [
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1],
    [-1, 2],
    [-1, -2],
    [1, 2],
    [1, -2]
  ]

  def enter_board
    set_position(color, [7, 1])
  end

  def to_s
    "\u2658".colorize(color)
  end
end
