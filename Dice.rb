class Dice
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
    while count < 7
      if count!=1 && count!=5
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