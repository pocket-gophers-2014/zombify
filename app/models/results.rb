
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

  private

  def update_user(infected, points = 0)
    @user.update_attributes(infected: infected, points: @user.points += points)
  end

  def update_opponent(infected, points = 0)
    @opponent.update_attributes(infected: infected, points: @opponent.points += points)
  end

  def determine_response
    return @result = "Attack yourself all you want, I guess..." if @opponent == @user
    return @result = "Why are you biting each other, Children?" if @user.infected && @opponent.infected
    return @result = "Why are you wasting precious cures?!" if !@user.infected && !@opponent.infected
    if @user.infected && @winner ##zombie user bites human
      create_post("#{@user.name} has bitten #{@opponent.name}","New Zombie")
      update_user(@user.infected, 300)
      update_opponent(true)
      check_stats
      return @result = "Mmmmmm....Brainsssss.....You have added to the horde."
    elsif @user.infected && !@winner ##zombie user misses human
      create_post("#{@opponent.name} has escaped #{@user.name}","Near Miss")
      update_opponent(@opponent.infected, 100)
      check_stats
      return @result = "You are feeling dizzy. The human has escaped. You still crave brains... "
    elsif @user.can_cure && @winner ##human cures zombie
      create_post("#{@opponent.name} has been cured by #{@user.name}","Human Reversion")
      update_user(@user.infected, 500)
      update_opponent(false)
      check_stats
      return @result = "You have successfully applied the cure!"
    elsif @user.can_cure && !@winner ##human fails zombie cure
      create_post("#{@user.name} failed a cure attempt on #{@opponent.name}","Cure Failed")
      create_post("#{@opponent.name} has bitten #{@user.name}","New Zombie")
      update_user(true)
      update_opponent(@opponent.infected, 100)
      check_stats
      return @result = "Your cure has failed. You feel your blood rising and crave delicious brains..."
    elsif !@user.can_cure
      create_post("#{@user.name} failed a cure attempt on #{@opponent.name}","Cure Failed")
      create_post("#{@opponent.name} has bitten #{@user.name}", "New Zombie")
      update_user(true)
      update_opponent(@opponent.infected, 100)
      check_stats
      return @result = "You do not have the cure! You have been bitten. Brainsssss...."
    else
      return @result = "Something has gone wrong."
    end
  end

  def create_post(body, title, audience = "both")
    Post.create(body: body, title: title, audience: audience)
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
      create_post(@message[1], @message[0], "human")
      @end_game = true
    elsif Stats.all_zombie?
      @message = Message.zombie_messages.last
      create_post(@message[1], @message[0], "zombie")
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
        create_post(zombie_messages[7][1],zombie_messages[7][0],"human")
        create_post(human_messages[7][1], human_messages[7][0], "zombie")
      when 50..53
        create_post(zombie_messages[6][1],zombie_messages[6][0],"zombie")
        create_post(human_messages[6][1],human_messages[6][0],"human")
    end
  end

end