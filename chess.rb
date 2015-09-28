require_relative 'board'

class Game
  attr_reader :game_board
  attr_accessor :current_player

  def initialize
    @game_board = Board.new(true)
    # @player_red = players[0]
    # @player_black = players[1]
    @current_player = :red
  end

  def play
    until game_board.check_mate?(current_player)
      system("clear")
      game_board.render
      begin
        current_move = prompt
        game_board.move(current_move[0], current_move[1], current_player)
      rescue ChessError => e
        p e.message
        retry
      end
      switch_players!
    end
    game_board.render
    p "GAME OVER"
  end

  def prompt
    p "#{current_player}'s turn'"
    p "Enter Start Position: "
    start_pos = gets.chomp.split(",").map(&:to_i)
    p "Enter End Position: "
    end_pos = gets.chomp.split(",").map(&:to_i)
    [start_pos, end_pos]
  end

  def switch_players!
    self.current_player = current_player == :red ? :black : :red
  end

end

class ChessError < StandardError
end


if $PROGRAM_NAME == __FILE__
  x = Game.new
  x.play
end
