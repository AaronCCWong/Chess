require_relative '../stepping_piece'

class King < SteppingPiece
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
      board[[7,4]] = self
      self.pos = [7, 4]
    else
      board[[0, 4]] = self
      self.pos = [0, 4]
    end
  end


  def to_s
    "\u2654".colorize(color)
  end
end
