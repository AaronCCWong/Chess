require_relative '../piece'

class Pawn < Piece
  OFFSET_BLACK = [1, 0]

  BLACK_CAPTURING = [
    [1, 1],
    [1, -1]
  ]

  OFFSET_RED = [-1, 0]

  RED_CAPTURING = [
    [-1, -1],
    [-1, 1]
  ]

  def possible_moves
    offset = color == :black ? OFFSET_BLACK : OFFSET_RED
    capture_offset = color == :black ? BLACK_CAPTURING : RED_CAPTURING
    poss_moves = []
    poss_moves += forward_moves(offset)
    capture_offset.each do |coord|
      new_pos = [pos[0] + coord[0], pos[1] + coord[1]]
      poss_moves << new_pos if can_capture?(new_pos, capture_offset)
    end
    poss_moves
  end

  def forward_moves(offset)
    poss_moves = []
    row = color == :black ? 1 : 6
    new_pos = [pos[0] + offset[0], pos[1] + offset[1]]
    if can_move_forward?(new_pos, offset)
      poss_moves << new_pos
      second_pos = [new_pos[0] + offset[0], new_pos[1] + offset[1]]
      if pos[0] == row && can_move_forward?(second_pos, offset)
        poss_moves << second_pos
      end
    end
    poss_moves
  end

  def can_move_forward?(new_pos, offset)
    in_board?(new_pos) && board.empty?(new_pos)
  end

  def can_capture?(new_pos, offset)
    in_board?(new_pos) && !board.empty?(new_pos) &&
      board[new_pos].color != color
  end

  def enter_board
    populate_pawns(color)
  end

  def populate_pawns(color)
    color == :red ? x = 6 : x = 1
    y = 0
    loop do
      if board.empty?([x, y])
        board[[x, y]] = self
        @pos = [x, y]
        break
      end
      y += 1
    end
  end

  def to_s
    "\u265F".colorize(color)
  end
end
