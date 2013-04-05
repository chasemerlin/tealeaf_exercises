puts "What is the first number?"
num1 = gets.chomp.to_i


puts "What is the second number?"
num2 = gets.chomp.to_i


puts "What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide"
operation = gets.chomp

if operation == '1'
	result = num1 + num2
elsif operation == '2'
	result = num1 - num2
elsif operation == '3'
	result = num1 * num2
elsif operation == '4'
	result = num1.to_f / num2.to_f
end
		
puts "The result is #{result}"