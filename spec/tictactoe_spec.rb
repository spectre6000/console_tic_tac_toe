require_relative '../lib/tictactoe.rb'

describe "play" do

	before(:each) do 
		allow(x).to receive(:puts)
	end

	let(:x) { Session.new }

	it "gets and creates players" do
		expect(x).to receive(:puts).with("\nPlayer X name:")
		allow(STDIN).to receive(:gets) { 'p1' }
		allow(x).to receive(:get_player).with("X") { Player.new("p1", "X", 0) }
		expect(x).to receive(:puts).with("\nPlayer O name:")
		allow(STDIN).to receive(:gets) { 'p2' }
		allow(x).to receive(:get_player).with("O") { Player.new("p2", "O", 0) }
		expect(@player1.name).to eql('p1')
		x.play
	end

	it "gets the max score for the game" do
		expect(x).to receive(:puts).with("\nBest out of how many?")
		allow(STDIN).to receive(:gets) { '3' }
		x.play
	end

#	Can't get this one to play nice... Assigning values from running test code above...
  it "displays game score" do
    allow(x).to receive(:get_player).with("X") { Player.new("p1", "X", 0) }
    allow(x).to receive(:get_player).with("O") { Player.new("p2", "O", 2) }
    expect(x).to receive(:puts).with("\np1: 0 \np2: 2")
    x.print_score
    x.play
  end

	xit "detects a winner" do
		allow(x).to receive(:get_player).with("X") { Player.new("p1", "X", 2) }
		player2 = Player.new("p2", "O", 2)
		x.winning_score = 2
		x.winner
		expect(x).to receive(:puts).with("\np2 WINS!!!")
		x.play
	end

end

describe "Player" do

	it "retains players' names and scores" do
		player1 = Player.new("p1", "X", 0)
		player2 = Player.new("p2", "O", 2)
		expect(player1.name).to eql("p1")
		expect(player2.name).to eql("p2")
		expect(player1.mark).to eql("X")
		expect(player2.mark).to eql("O")
		expect(player1.score).to eql(0)
		expect(player2.score).to eql(2)
	end

end

# describe "Game" do

#	it ""

# end



describe(Board) do
	describe "#three_in_a_row?" do
		context "there isn't a winner" do
			it "returns false" do
				# set up
				board = Board.new

				# kick off
				three_in_a_row_value = board.three_in_a_row?

				# expectation
				expect(three_in_a_row_value).to eq(false)
			end
		end

		context "there is a winner" do
			[[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]].each do |spaces|
				it "changes the value of win" do
					#set up
					space_1 = spaces[0]
					space_2 = spaces[1]
					space_3 = spaces[2]
					board = Board.new
					board.make_mark("@s#{space_1}", "X")
					board.make_mark("@s#{space_2}", "X")
					board.make_mark("@s#{space_3}", "X")

					#kick off
					three_in_a_row_value = board.three_in_a_row?

					# kickoff and expectation
					expect(three_in_a_row_value).to eql(true), "expected a true, got #{three_in_a_row_value} with #{spaces}"
				end
			end
		end
	 end

	describe "#make_mark_for_testing" do
#		["@s1","@s2","@s3","@s4","@s5","@s6","@s7","@s8","@s9"].each do |space|
			it "places player's tick in the correct space" do
				#set up
				board = Board.new
				box = Space.new("X")

				#kick off
				board.make_mark_for_testing(box, "X")

				#expectation
				expect(box.tick).to eql("X")
			end
		end
#	end
end

describe "#get_player" do
	it "initiates players" do
		#setup
		Interface.stub(:get_player_name).and_return("bob")

		#kickoff
		return_value = Session.new.get_player

		#expectation
		expect(return_value).to be_an_instance_of(Player)
	end
end


