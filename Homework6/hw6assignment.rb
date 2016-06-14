# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  All_Pieces = Piece::All_Pieces.concat( # Enhancement 2
                [[[[0, 0], [-1, 0], [1, 0], [2, 0], [-2,0]], # long 5 (only needs two)
                [[0, 0], [0, -1], [0, 1], [0, 2], [0, -2]]],
                rotations([[0, 0], [0, 1], [1, 0]]), # 3 block
                rotations([[0, 0], [0, 1], [-1, 0], [1, 0], [-1, 1]])])
  # your enhancements here
  def self.cheat_piece (board)
  #  if @cheated
  #  MyPiece.new([[[0,0]]], board)
  #  else
    MyPiece.new([[[0,0]]], board)
  # end
  end
end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
  end

  def cheat_piece
    if !game_over? and @game.is_running?
      @cheated = true
    end
  end

  def next_piece
    if @cheated
      @current_block = MyPiece.cheat_piece(self)
      @current_pos = nil
      @cheated = false
      @score -= 100
    else
      @current_block = MyPiece.next_piece(self)
      @current_pos = nil
    end
  end
end

class MyTetris < Tetris
  # your enhancements here
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
    super()
    @root.bind('u', lambda {@board.rotate_counter_clockwise;@board.rotate_counter_clockwise}) #Enhancement 1
    @root.bind('c', lambda {@board.cheat_piece})
  end
end