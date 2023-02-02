class Game
  
  @@turn = 1
  @@winer = ""

  public

  def initialize
    puts "Player 1. enter your name: \n"
    @player_1_name = gets.chomp
    puts "Player 2. enter your name: \n"
    @player_2_name = gets.chomp
    @board = Array.new(3) {Array.new(3,"-")}
  end

  def display_board(board)
    puts "\n"
    puts "
          | #{board[0][0]} | #{board[0][1]} | #{board[0][2]} |
          | #{board[1][0]} | #{board[1][1]} | #{board[1][2]} |
          | #{board[2][0]} | #{board[2][1]} | #{board[2][2]} |
         "
    puts "\n"
  end

  def player_turn(turn)
    if turn.odd?
      player_choice(@player_1_name, "X")
    else
      player_choice(@player_2_name, "O")
    end
  end

  def play_game
    puts "The Battlefield: "
    display_board(@board)
    
    until @@turn >= 10
      player_turn(@@turn)
      check_inline()
      check_down()
      check_diagonal()
      display_board(@board)
    end
    display_winner()
  end

  def player_choice(name, symbol)
    puts "#{name}, please enter coordinates for your choice separated by a space"

    input = gets.chomp
    input_arr = input.split
    coordinate_one = input_arr[1].to_i - 1
    coordinate_two = input_arr[0].to_i - 1 
    until input.match(/\s/) && coordinate_one.between?(0,2) && coordinate_two.between?(0,2) && @board[coordinate_one][coordinate_two] == "-"
      input = gets.chomp
      input_arr = input.split
      coordinate_one = input_arr[1].to_i - 1 
      coordinate_two = input_arr[0].to_i - 1 
    end
    add_to_board(coordinate_one, coordinate_two, symbol)
  end
  
  def add_to_board(coordinate_one, coordinate_two, symbol)
    @board[coordinate_one][coordinate_two] = symbol
    @@turn += 1
  end

  def check_inline
    @board.each do |line|
      if line.all? {|element| element == "X"}
        @@winer = "X"
        @@turn = 10
      elsif line.all? {|element| element == "O"}
        @@winer = "O"
        @@turn = 10
      else
        nil
      end    
    end
  end

  def check_diagonal
    center_sym = @board[1][1]
    if center_sym == "X" || center_sym == "O"
      if @board[2][2] == center_sym && @board[0][0] == center_sym
        @@winer = center_sym
        @@turn = 10
      elsif @board[0][2] == center_sym && @board[2][0] == center_sym
        @@winer = center_sym
        @@turn = 10
      else
        nil
      end
    end
  end

  def check_down
    flat_hash = @board.flatten
    flat_hash.each_with_index do |sym, index|
      if sym == "X" && flat_hash[index+3] == "X" && flat_hash[index+6] == "X"
        @@winer = "X"
        @@turn = 10
      elsif
        sym == "O" && flat_hash[index+3] == "O" && flat_hash[index+6] == "O"
        @@winer = "O"
        @@turn = 10
      else
        nil
      end
    end
  end

  def display_winner()
    if @@winer == "X"
      puts "#{@player_1_name} Wins!!!"
    elsif @@winer == "O"
      puts "#{@player_2_name} Wins!!!"
    else
      puts "Draw!"
    end

  end  

  puts "Welcome to the game of tic-tac-toe"
  puts "These are the coordinates for the grid!"
  puts "\n"
  puts "
        | 11 | 21 | 31 |
        | 12 | 22 | 32 |
        | 13 | 23 | 33 |
        "
  puts "\n"
end

game = Game.new()
game.play_game