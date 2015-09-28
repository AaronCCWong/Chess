require_relative 'piece'

class SteppingPiece < Piece
  def possible_moves
    all_sliding_moves = []
    self.class::OFFSET.each do |coord|
      new_pos = [pos[0] + coord[0], pos[1] + coord[1]]
      if in_board?(new_pos) && valid_move?(new_pos)
        all_sliding_moves << new_pos
      end
    end
    all_sliding_moves
  end

  private

  def valid_move?(new_pos)
    board.empty?(new_pos) || color != board[new_pos].color
  end
end
