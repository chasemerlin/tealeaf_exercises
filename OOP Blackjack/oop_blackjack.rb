require 'pry'

class Card
	attr_accessor :suit, :value

	def initialize(suit, value)
		@suit = suit
		@value = value
	end

	def to_s
	    "The #{value} of #{suit}"
	end
end

class Deck
	attr_accessor :cards

	def initialize
		@cards = []
		['Ace','2','3','4','5','6','7','8','9','10','Jack','Queen','King'].each do |face|
			['Hearts','Spades','Diamonds','Clubs'].each do |suit|
				cards << Card.new(suit,face)
			end
		end
		@cards.shuffle!
	end

	def deal_a_card
		cards.pop
	end
end

class Player 
	attr_accessor :name, :hand

	def initialize
		@name = ''
		@hand = Hand.new
	end

	def is_busted?
		hand.total > 21
	end
end

class Dealer < Player
	
	def initialize
		@name = "Dealer"
		@hand = Hand.new
	end

end

class Hand
	attr_accessor :cards

	def initialize
		@cards = []
	end

	def total
		total = 0
		cards.each do |card|
			val = card.value
			if val == 'Ace'
				total += 11
			elsif val == 'Jack' || val == 'Queen' || val == 'King'
				total += 10
			else 
				total += val.to_i
			end
		end

		#Correct for Aces
		number_of_aces = cards.select { |card| card.value == 'Ace' }.count
		number_of_aces.times { total -= 10 if total > 21 }

		total
	end

	def add_a_card
	end

end

class Game
	attr_accessor :player, :dealer, :deck

	def initialize
		@player = Player.new
		@dealer = Dealer.new
		@deck = Deck.new
	end

	def welcome
		puts "Welcome to Terminal Blackjack. What is your name?"
		input_name = gets.chomp 
		player.name = input_name
	end

	def deal_cards
		player.hand.cards << deck.deal_a_card
		dealer.hand.cards << deck.deal_a_card
		player.hand.cards << deck.deal_a_card
		dealer.hand.cards << deck.deal_a_card
		puts "--------------BLACKJACK---------------"
		puts "You were dealt: #{player.hand.cards.first} and #{player.hand.cards.last}"
		puts "Your current total is #{player.hand.total}"
		puts "The Dealer's up card is: #{dealer.hand.cards.last}"	
	end

	def player_turn
		if player.hand.total == 21
			puts "You have 21! Now it's the dealer's turn"
			return
		end
		puts "You're up, #{player.name}! Press 1 to Hit or 2 to Stay"
		hit_or_stay = gets.chomp
		while hit_or_stay == '1'
			new_card = deck.deal_a_card
			player.hand.cards << new_card
			puts "You were dealt #{new_card}. Your new total is #{player.hand.total}"
			abort("You bust. You lose. GAME OVER") if player.is_busted?
			if player.hand.total == 21
				puts "You have 21! You stay."
				return
			end
			puts "Press 1 to Hit or 2 to Stay"
			hit_or_stay = gets.chomp
		end
		puts "You stay with #{player.hand.total}"
	end

	def dealer_turn
		while dealer.hand.total < 17
			puts "Dealer hits."
			new_card = deck.deal_a_card
			dealer.hand.cards << new_card
			puts "Dealer got dealt #{dealer.hand.cards.last} for a new total of #{dealer.hand.total}"
			abort("Dealer busts! You Win!") if dealer.is_busted?
		end
		puts "Dealer stays with #{dealer.hand.total}"
	end

	def find_winner
		player_total = player.hand.total
		dealer_total = dealer.hand.total
		puts "You have #{player_total} and the dealer has #{dealer_total}"
		if player_total > dealer_total
			puts "You Win!"
		elsif dealer_total > player_total
			puts "You Lose!"
		else 
			puts "It's a tie!"
		end
	end

	def start_game
		welcome
		deal_cards
		player_turn
		dealer_turn
		find_winner
	end
end

game =  Game.new
game.start_game






