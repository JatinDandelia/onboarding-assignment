#This method is used for rolling the dice
def roll (number)
    values = []
    number.times do
      values << rand(5)+1
    end 
    return values
end

#This method is used for calculating the score of a given turn
def score(dice)
    temp = [0,0,0,0,0,0]
    dice.each do |item|
      temp[item-1] += 1 
    end
    count = 0
    score = 0
    while count<6
      if count == 0
        value = temp[count] - 3
        if value >= 0
          score += 1000
          score += value * 100
        else
           score += temp[count] * 100
        end
      
      elsif count == 4
        value = temp[count] - 3
        if value >= 0
          score += ((count+1) * 100 )
          score += value * 50
        else
           score += temp[count] * 50
        end  
      
      else
        if temp[count]>=3
          score += ((count+1) * 100 )

        end
      end
      count += 1
      
      
   end
   return score
   
end


#This method counts the number of non-scoring dices in a single turn
def non_score(dice)
  hash = { 1 => 0, 2 => 0, 3 => 0, 4 => 0, 5 => 0, 6 => 0}
  non_counting = Array.new
  dice.each do |item|
    hash[item] += 1 
  end
  count = 1
  non_counting = 0
  while count<7
    if count!=1 && count !=5
      value = hash[count]
      if value > 3
        non_counting += (value - 3)
      elsif value == 1 || value ==2
        non_counting += value
      end
    end
    count += 1
     
 end
 return non_counting
 


end

class Game
    attr_reader :number, :turn
    def initialize(number, turn)
        @number = number
        @turn = turn
        dices = roll (5)                      #Comment this if uncommenting line 85
        #dices = gets.split(' ').map &:to_i   #Uncomment for giving manual inputs (Same for line 120)
        print "Player #{@number} rolls: "
        dices.each {|x| print "#{x} " }
        
        score= score(dices)

        if ($global_hash[@number]==0 && score>=300)
            $global_hash[@number] += score
        elsif ($global_hash[@number]!=0)
            $global_hash[@number]+= score
        end
        puts "Score in this round: #{score}"
        puts "Total score: #{$global_hash[number]}"

        if $global_hash[number]>=3000
          $won = true
          return
        end

        #Now calculate non-scoring turns
        non_scoring_dice= non_score(dices)
        if (score!=0 && non_scoring_dice>0)
            non_scoring(non_scoring_dice)
        end
        
        

    end
    
    #This method looks after if the player wants to still play or not. If answer is "y" then it keeps on running
    def non_scoring(non_scoring_dice)
        puts "Do you want to roll the non-scoring #{non_scoring_dice} dices?(y/n):"
        ans = gets.chomp.to_s
        if (ans=='y')
            dices = roll(non_scoring_dice)   #Comment this if uncommenting line 120
            #dices = gets.split(' ').map &:to_i   #Uncomment for giving manual inputs (Same for line 85)
            print "Player #{@number} rolls: "
            dices.each {|x| print "#{x} " }
            score= score(dices)

            if ($global_hash[@number]==0 && score>=300)
                $global_hash[@number] += score
            elsif ($global_hash[@number]!=0)
                $global_hash[@number]+= score
            end
            puts "Score in this round: #{score}"
            puts "Total score: #{$global_hash[number]}"

            if $global_hash[number]>=3000
              $won = true
              return
            end

            non_scoring_dice=non_score(dices)
            if (score!=0 && non_scoring_dice>0)
                non_scoring(non_scoring_dice)
            end
            
        end

        
    end

end

print "Enter number of players: "
no_player = gets.chomp.to_i


$global_hash = Hash.new #Used to maintain total score of players
$won = false #To know if any player has won

#Makes total keys in global hash according to number of players
i=1
while i<= no_player
    $global_hash[i] = 0
    i+=1
end
puts "#{$global_hash}"

turn = 1

#Keeps on running until a player wins
while true
    puts "Turn No. #{turn}"
    i=1
    while i<= no_player
        player = Game.new(i, turn)
        if $won==true
          puts "Player #{i} wins"
          break
        end
        i+=1
    end
    if $won==true
      break
    end
    puts ""
    puts "**************"
    puts ""
    turn+=1
end

