require './Game'

print "Enter number of players: "
no_player = gets.chomp.to_i

$global_hash = Hash.new #Used to maintain total score of players
$won = false #To know if any player has won

#Makes total keys in global hash according to number of players
i = 1
while i<= no_player
    $global_hash[i] = 0
    i += 1
end
puts "#{$global_hash}"

turn = 1

#Keeps on running until a player wins
while true
  puts "Turn No. #{turn}"
  i = 1
  while i<= no_player
    player = Game.new(i, turn)
    if $won == true
      puts "Player #{i} wins"
      break
    end
    i += 1
  end
  if $won == true
    break
  end
  puts ""
  puts "**************"
  #puts ""
  turn+=1
end

