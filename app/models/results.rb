class Results
  attr_reader :result, :end_game

  def initialize(params, user)
    @winner = eval_string(params["result"])
    @opponent = determine_opponent(params["opponent"])
    @user = user
    @end_game = false
    verify_results
  end

  def determine_opponent(opponent)
    handle = parse_opponent_id(opponent)
    User.find_by_handle(handle) || "invalid"
  end

  def verify_results
    return @result = "invalid user code" if @opponent == "invalid"
    determine_response
  end

  def determine_response
    return @result = "Bite yourself all you want, I guess..." if @opponent == @user
    if @user.infected && @opponent.infected
      return @result = "Why are you biting each other, Children?"
    elsif !@user.infected && !@opponent.infected
      return @result = "Why are you wasting precious cures?!"
    elsif @user.infected && @winner ##zombie user bites human
      Post.create(body:"#{@user.name} has bitten #{@opponent.name}", title:"New Zombie", audience:"both")
      @user.update_attributes(points: @user.points += 300)
      @opponent.update_attributes(infected: true)
      check_stats
      return @result = "Mmmmmm....Brainsssss.....You have added to the horde."
    elsif @user.infected && !@winner ##zombie user misses human
      p @winner
      Post.create(body:"#{@opponent.name} has escaped #{@user.name}", title:"Near Miss", audience:"both")
      @opponent.update_attributes(points: @opponent.points += 100)
      check_stats
      return @result = "You are feeling dizzy. The human has escaped. You still crave brains... "
    elsif @user.can_cure && @winner ##human cures zombie
      Post.create(body:"#{@opponent.name} has been cured by #{@user.name}", title:"Human Reversion", audience:"both")
      @user.update_attributes(points: @user.points += 500)
      @opponent.update_attributes(infected: false)
      check_stats
      return @result = "You have successfully applied the cure!"
    elsif @user.can_cure && !@winner ##human fails zombie cure
      Post.create(body:"#{@user.name} failed a cure attempt on #{@opponent.name}", title:"Cure Failed", audience:"both")
      Post.create(body:"#{@opponent.name} has bitten #{@user.name}", title:"New Zombie", audience:"both")
      @user.update_attributes(infected: true)
      @opponent.update_attributes(points: @opponent.points += 100)
      check_stats
      return @result = "Your cure has failed. You feel your blood rising and crave delicious brains..."
    elsif !@user.can_cure
      @opponent.update_attributes(points: @opponent.points += 100)
      Post.create(body:"#{@user.name} failed a cure attempt on #{@opponent.name}", title:"Cure Failed", audience:"both")
      Post.create(body:"#{@opponent.name} has bitten #{@user.name}", title:"New Zombie", audience:"both")
      @user.update_attributes(infected: true)
      ##create new post, with audience of "both"
      ##update both users if they have earned points
      ##update people's secret codes?
      ##update session?
      ##check the conditonals in the rest of the game logic
      ##return text to render to the battle result page
      check_stats
      return @result = "You do not have the cure! You have been bitten. Brainsssss...."
    else
      return @result = "Something has gone wrong."
    end
    #check conditional stats in each if branch?
  end

  def parse_opponent_id(opponent)
    opponent_id = opponent.match(/=(.*)/)
    return $1
  end

  def eval_string(boolean_string)
    boolean_string == 'true'
  end

  def check_stats
    if Stats.all_human?
      @message = Message.human_messages.last
      Post.create(title: @message[0], body: @message[1], audience: "human")
      @end_game = true
    elsif Stats.all_zombie?
      @message = Message.zombie_messages.last
      Post.create(title: @message[0], body: @message[1], audience: "zombie")
      @end_game = true
    else
      zombies_percentage = Stats.percent_zombies
      remaining_stats(zombies_percentage)
    end
  end

  def remaining_stats(zombie_percentage)
    zombie_messages = Message.zombie_messages
    human_messages = Message.human_messages
    case zombie_percentage
      when 90..93
        Post.create(title: zombie_messages[7][0], body: zombie_messages[7][1],audience: "zombie")
        Post.create(title: human_messages[7][0], body: human_messages[7][1],audience: "human")
      when 50..53
        Post.create(title: zombie_messages[6][0], body: zombie_messages[6][1],audience: "zombie")
        Post.create(title: human_messages[6][0], body: human_messages[6][1], audience: "human")
    end
  end

end
