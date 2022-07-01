require "rspec"

#This Rspec file tests the score and non-score function. In score function it checks if it returns
#correct score for a particular dice throw. In non-score it checks if it is correctly calculating
#the non-scoring dices.


class GreedGame
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
end



 describe GreedGame do 
    context "It has all the rules" do 
       
       it "On throw of random numbers" do 
          sa = GreedGame.new 
          test_string = [5,5,1,2,1] 
          expect(sa.score test_string).to eq 300
       end 


       it "On throw of non-scoring numbers" do 
        sa = GreedGame.new 
        test_string = [4,4,3,2,6] 
        expect(sa.score test_string).to eq 0
      end

      it "On throw of 3 non-scoring numbers" do 
        sa = GreedGame.new 
        test_string = [4,4,3,4,6] 
        expect(sa.score test_string).to eq 400
      end 
         
      it "Counting of non-scoring numbers (with 3 non-scoring number)" do 
        sa = GreedGame.new 
        test_string = [4,4,3,4,6] 
        expect(sa.non_score test_string).to eq 2
      end 

      it "Counting of non-scoring numbers" do 
        sa = GreedGame.new 
        test_string = [1,3,2,4,5] 
        expect(sa.non_score test_string).to eq 3
      end 

      it "Counting of non-scoring numbers" do 
        sa = GreedGame.new 
        test_string = [4,5] 
        expect(sa.non_score test_string).to eq 1
      end 
   
       
    end 
 end