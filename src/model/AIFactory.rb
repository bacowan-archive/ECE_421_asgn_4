require_relative 'EasyAI'
require_relative 'MediumAI'
require_relative 'AI'

class AIFactory

  # aiLevel: the difficulty level: 1-3
  def createAI(aiLevel,winCondition,player,opponent,columnController,game)

    if aiLevel == false
      return false
    end

    if aiLevel == 1
      ai = AI.new(EasyAI.new(player,winCondition),player,columnController)
    elsif aiLevel == 2
      ai = AI.new(MediumAI.new(player,opponent,winCondition),player,columnController)
    elsif aiLevel == 3
      ai = AI.new(EasyAI.new(player,winCondition),player,columnController)
    else
      return false
    end

    # make sure the ais know what's going on in the game
    game.addAIObserver(ai)

  end

end