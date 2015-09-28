require_relative 'piece'

class SlidingPiece < Piece
  def possible_moves
    poss_moves = []
    self.class::OFFSET.each do |coord|
      new_pos = [pos[0] + coord[0], pos[1] + coord[1]]
      until !in_board?(new_pos) || !board.empty?(new_pos)
        poss_moves << [new_pos[0], new_pos[1]]
        new_pos[0] += coord[0]
        new_pos[1] += coord[1]
      end
      if in_board?(new_pos) && board[new_pos].color != color
        poss_moves << new_pos
      end
    end
    poss_moves
  end
end
