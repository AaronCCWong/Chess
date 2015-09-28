require_relative './pieces/bishop'
require_relative './pieces/king'
require_relative './pieces/knight'
require_relative './pieces/pawn'
require_relative './pieces/queen'
require_relative './pieces/rook'

class Board
  GRID_SIZE = 8

  attr_reader :grid
  attr_accessor :graveyard

  def self.blank_grid
    Array.new(8) { Array.new(8) { " " } }
  end

  def initialize(new_game)
    @graveyard = []
    @grid = Board.blank_grid
    create_chess_pieces if new_game
  end

  def create_chess_pieces
    2.times { Rook.new(:black, self) }
    2.times { Rook.new(:red, self) }
    2.times { Knight.new(:black, self) }
    2.times { Knight.new(:red, self) }
    2.times { Bishop.new(:black, self) }
    2.times { Bishop.new(:red, self) }
    1.times { Queen.new(:black, self) }
    1.times { Queen.new(:red, self) }
    1.times { King.new(:black, self) }
    1.times { King.new(:red, self) }
    8.times { Pawn.new(:black, self) }
    8.times { Pawn.new(:red, self) }
  end

  def dup
    new_board = Board.new(false)
    self.grid.flatten.each do |tile|
      if tile.is_a?(Piece)
        new_board[tile.pos] = tile.dup
        new_board[tile.pos].board = new_board
      end
    end

    new_board.render
    new_board
  end

  def empty?(pos)
    self[pos] == " "
  end

  def render
    puts "  0 1 2 3 4 5 6 7"
    grid.each_with_index do |row, idx|
      print "#{idx} "
      row.each_with_index do |tile, idy|
        bg_color = ((idx + idy).even? ? :light_blue : :light_red)
        output = tile.nil? ? "  " : tile.to_s + " "
        print output.colorize(:background => bg_color)
      end
      print "\n"
    end
    print "\n\n"

    w = graveyard.select{|piece| piece.color == :b}
    b = graveyard.select{|piece| piece.color == :w}
    puts "white: #{w.each(&:to_s)}"
    puts "black: #{b.each(&:to_s)}"
  end

  def move(start_pos, end_pos, current_player)
    if self.empty?(start_pos) ||
      !self[start_pos].possible_moves.include?(end_pos) ||
      self[start_pos].expose_king?(end_pos) ||
      self[start_pos].color != current_player

      raise ChessError.new("Not Possible")
    end

    move!(start_pos, end_pos)
  end

  def check_mate?(color)
    if in_check?(color)
      player_in_check = self.grid.flatten.select do |piece|
        piece != " " && piece.color == color
      end
      return true if player_in_check.all? do |piece|
        piece.possible_moves.select { |move| !piece.expose_king?(move) }.empty?
      end
    end
    false
  end

  def move!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = " "
    self[end_pos].pos = end_pos
  end

  def in_check?(color)
    king_pos = self.grid.flatten.find do |tile|
      tile.class == King && tile.color == color
    end.pos

    opponent_pieces = self.grid.flatten.select do |tile|
      tile != " " && tile.color != color
    end
    opponent_pieces.any? { |piece| piece.possible_moves.include?(king_pos) }
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, object)
    x, y = pos
    @grid[x][y] = object
  end
end
