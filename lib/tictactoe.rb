class Interface
	
	def print_board
		puts "\n\n#{ @s1.tick }|#{ @s2.tick }|#{ @s3.tick }\n-----\n#{ @s4.tick }|#{ @s5.tick }|#{ @s6.tick }\n-----\n#{ @s7.tick }|#{ @s8.tick }|#{ @s9.tick }\n\n\n"
	end

	def get_move
		puts "#{ @turn.name }, which space would you like to play?"
		space = "@s" + gets.chomp.upcase
		return space
	end
end

class Session

	attr_accessor :winning_score

	def initialize(winning_score = 0)
		@interface = Interface.new
		@winning_score = winning_score
	end

	def play
		get_players
		max_score
		while @player1.score != @winning_score && @player2.score != @winning_score
			print_score
		  game = Game.new(@player1, @player2)
		  game.coin_toss
		  while game.cont == "YES" 
			  game.move
			  game.win
			  game.switch_turns
		  end
		end
		winner
	end

	private
  
  def get_players
    @player1 = get_player("X")
    @player2 = get_player("O")
  end

  def get_player(mark)
    name = @interface.get_player_name
    Player.new(name, mark, 0)
  end

	def max_score
		puts "\nBest out of how many?"
		max = gets.chomp
		@winning_score = (max.to_f/2).ceil
	end

	def print_score
		puts "\n#{@player1.name}: #{@player1.score} \n#{@player2.name}: #{@player2.score}"
	end

	def winner
		if @player1.score == @winning_score
			puts "\n#{@player1.name} WINS!!!"
		elsif @player2.score == @winning_score
			puts "\n#{@player2.name} WINS!!!"
		end
	end

end




class Player
	attr_accessor :name, :mark, :score
	def initialize(name, mark, score)
		@name = name
		@mark = mark
		@score = score
	end
end



class Game

	attr_accessor :player1, :player2, :turn, :cont
	
	def initialize(player1, player2, turn = nil, bench = nil, move = nil, cont = "YES")
		@player1 = player1
		@player2 = player2
		@turn = turn
		@bench = bench
		@cont = cont
		@board = Board.new()
	end
	
	
	def coin_toss
		caller = [@player1, @player2].sample
		name = caller.name
		coin = ["TAILS", "HEADS"].sample
		puts "\n#{name}, heads or tails?"
		call = gets.chomp.upcase
		if call == coin
			@turn = caller

			puts "\n#{coin}! You go first!"
		else
			if caller == @player1
				@turn = @player2
				puts "#{coin}! Sorry, #{@player1.name}, #{@player2.name} goes first."
			else
				@turn = @player1
				puts "#{coin}! Sorry, #{@player2.name}, #{@player1.name} goes first."
			end			
		end		
		if @turn == @player1
			@bench = @player2
		else
			@bench = @player1
		end
	end

	def move
		# @interface.print_board #********************************************************
		# mark = @turn.mark
		# puts "#{@turn.name}, which space would you like to play?"
		# space = "@s" + gets.chomp.upcase
		@board.make_mark(space, mark)
	end

	def win
		if board.three_in_a_row?
			@cont = "NO"
			

			@interface.print_board #********************************************************
			

			@turn.score += 1
			puts "#{@turn.name} wins this round!"
		end
	end

	def switch_turns
		if @turn == @player1
			@turn = @player2
			@bench = @player1
		else
			@turn = @player1
			@bench = @player2
		end
	end

end




class Board

	attr_accessor :win

	def initialize(win = nil)
		@win = win
		9.times do |x|
			x += 1
			y = "@s" + x.to_s
			instance_variable_set( y , Space.new(x.to_s))
		end
	end

	# def print_board
	# 	puts "\n\n#{@s1.tick}|#{@s2.tick}|#{@s3.tick}\n-----\n#{@s4.tick}|#{@s5.tick}|#{@s6.tick}\n-----\n#{@s7.tick}|#{@s8.tick}|#{@s9.tick}\n\n\n"
	# end


	def make_mark(space, mark)
		instance_variable_get(space).tick = mark
	end

	def make_mark_for_testing(space, mark)
		space.tick = mark
	end

	def three_in_a_row?
		if @s1.tick == @s2.tick && @s2.tick == @s3.tick || 
		 	@s4.tick == @s5.tick && @s5.tick == @s6.tick || 
		 	@s7.tick == @s8.tick && @s8.tick == @s9.tick || 
		 	@s1.tick == @s4.tick && @s4.tick == @s7.tick || 
		 	@s2.tick == @s5.tick && @s5.tick == @s8.tick || 
		 	@s3.tick == @s6.tick && @s6.tick == @s9.tick || 
		 	@s1.tick == @s5.tick && @s5.tick == @s9.tick || 
		 	@s3.tick == @s5.tick && @s5.tick == @s7.tick
		 	true
		else
			false
		end
	end

end




class Space

	attr_accessor :tick
	
	def initialize(tick)
		@tick = tick
	end

end





#x = Session.new


