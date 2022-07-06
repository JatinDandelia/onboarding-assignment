require './Dice.rb'

class Game
    attr_reader :number, :turn
    
    def initialize(number, turn)
      dice = Dice.new
      @number = number
      @turn = turn
      dices = dice.roll (5)                      #Comment this if uncommenting line 85
      #dices = gets.split(' ').map &:to_i   #Uncomment for giving manual inputs (Same for line 120)
      print "Player #{@number} rolls: "
      dices.each {|x| print "#{x} " }
          
      score = dice.score(dices)
  
      if ($global_hash[@number] == 0 && score >= 300)
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
      non_scoring_dice= dice.non_score(dices)
      if (score!=0 && non_scoring_dice>0)
        non_scoring(non_scoring_dice)
      end
    end
      
    #This method looks after if the player wants to still play or not. If answer is "y" then it keeps on running
    def non_scoring(non_scoring_dice)
      dice = Dice.new
      puts "Do you want to roll the non-scoring #{non_scoring_dice} dices?(y/n):"
      ans = gets.chomp.to_s
      if (ans == 'y')
        dices = dice.roll(non_scoring_dice)   #Comment this if uncommenting line 120
        #dices = gets.split(' ').map &:to_i   #Uncomment for giving manual inputs (Same for line 85)
        print "Player #{@number} rolls: "
        dices.each {|x| print "#{x} " }
        score= dice.score(dices)
  
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
  
        non_scoring_dice = dice.non_score(dices)
        if (score!=0 && non_scoring_dice>0)
          non_scoring(non_scoring_dice)
        end            
      end 
    end
  end