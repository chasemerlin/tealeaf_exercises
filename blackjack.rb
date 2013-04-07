def total(cards)
	arr = cards.map { |card| card[1] }
	
	total = 0 
	arr.each do |val|
		if val == 'A'
			total += 11
		elsif val.to_i == 0
			total += 10
		else
			total += val.to_i
		end
	end

	# Correct for Aces
	arr.count('A').times do
		total -= 10 if total > 21
	end	

	total
end

def blackjack?(cards)
	total(cards) == 21
end

def bust?(cards)
	total(cards) > 21
end

puts "Welcome to Blackjack friendo"

suit = ['Heart', 'Spade', 'Diamond', 'Club']
base_cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

deck = suit.product(base_cards)
deck.shuffle!

player_cards = []
dealer_cards = []

player_cards << deck.pop
dealer_cards << deck.pop
player_cards << deck.pop
dealer_cards << deck.pop

puts ""
puts "Dealer has #{dealer_cards[0]} and #{dealer_cards[1]} for a total of #{total(dealer_cards)}"
puts "You have #{player_cards[0]} and #{player_cards[1]} for a total of #{total(player_cards)}"
puts ""
puts "Would you like to hit or stay? 1) hit  2) stay"
response = gets.chomp

while response == '1'
	player_cards << deck.pop
	puts "You got #{player_cards.last} for a total of #{total(player_cards)}"

	abort("You have blackjack! You win!") if blackjack?(player_cards)
	abort("You bust. You lose") if bust?(player_cards)

	puts "Would you like to hit or stay? 1) hit  2) stay"
	response = gets.chomp
end

if response == '2' 
	puts "You stay. Time for the dealer's turn"

	while total(dealer_cards) < total(player_cards)
		dealer_cards << deck.pop
		puts "Dealer got #{dealer_cards.last} for a total of #{total(dealer_cards)}"

		abort("Dealer has blackjack! You lose!") if blackjack?(dealer_cards)
		abort("Dealer busts. You win") if bust?(dealer_cards)
	end

	puts "Dealer has #{total(dealer_cards)} and you have #{total(player_cards)}. You lose."
end



