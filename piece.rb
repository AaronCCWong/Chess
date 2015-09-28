require 'colorize'

class Piece
  attr_reader :color
  attr_accessor :pos, :board

  def initialize(color, board)
    @board = board
    @color = color
    @pos = nil
    enter_board
  end

  def expose_king?(new_pos)
    new_board = board.dup
    new_board.move!(pos, new_pos)
    new_board.in_check?(color)
  end

  def set_position(color, pos)
    color == :red ? set_red(pos) : set_black(pos)
  end

  def set_red(pos)
    if board.empty?(pos)
      board[pos] = self
      self.pos = pos
    else
      board[[pos[0], 7 - pos[1]]] = self
      self.pos = [pos[0], 7 - pos[1]]
    end
  end

  def set_black(pos)
    if board.empty?([0, pos[1]])
      board[[0, pos[1]]] = self
      self.pos = [0, pos[1]]
    else
      board[[0, 7 - pos[1]]] = self
      self.pos = [0, 7 - pos[1]]
    end
  end

  private

  def in_board?(pos)
    pos.all? { |el| el.between?(0,7) }
  end
end
