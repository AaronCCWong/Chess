require_relative '../sliding_piece'

class Queen < SlidingPiece
  OFFSET = [
    [1,0],
    [-1, 0],
    [0, 1],
    [0, -1],
    [1, 1],
    [1,-1],
    [-1, 1],
    [-1, -1]
  ]

  def enter_board
    if color == :red
      board[[7, 3]] = self
      self.pos = [7, 3]
    else
      board[[0, 3]] = self
      self.pos = [0, 3]
    end
  end

  def to_s
    "\u2655".colorize(color)
  end
end
