

class Results
    RESPONSE_MESSAGES = {
      human_attack_self: "Attack yourself all you want, I guess...",
      human_attack_human: "Why are you wasting precious cures?!",
      zombie_attack_zombie: "Why are you biting each other, Children?",
      user_converts_H_to_Z: "Mmmmmm....Brainsssss.....You have added to the horde.",
      user_fail_converts_H_to_Z: "You are feeling dizzy. The human has escaped. You still crave brains... ",
      successful_cure: "You have successfully applied the cure!",
      failed_cure: "Your cure has failed. You feel your blood rising and crave delicious brains...",
      no_cure_attempt: "You do not have the cure! You have been bitten. Brainsssss....",
      invalid_user_code: "invalid user code"
    }

    POST_MESSAGES = {
      user_converts_H_to_Z: ["%s has bitten %s","New Zombie"],
      user_fail_converts_H_to_Z: ["%s has escaped %s","Near Miss"],
      successful_cure: ["%s has been cured by %s","Human Reversion"],
      failed_cure: ["%s failed a cure attempt on %s","Cure Failed"],
      new_zombie: ["%s has bitten %s","New Zombie"]
    }
  attr_reader :response

  def initialize(user, opponent, user_win)
    @user = user
    @opponent = opponent
    @win = user_win
    verify_opponent
end

  def verify_opponent
    if @opponent == "invalid"
      @response = RESPONSE_MESSAGES[:invalid_user_code]
      return @response
    end
    determine_response
  end

  private

  def update_user(infected, points = 0)
    @user.update_attributes(infected: infected, points: @user.points += points, handle: @user.generate_handle)
  end

  def update_opponent(infected, points = 0)
    @opponent.update_attributes(infected: infected, points: @opponent.points += points, handle: @opponent.generate_handle)
  end

  def determine_response
    return @response = RESPONSE_MESSAGES[:human_attack_self] if @opponent == @user
    return @response = RESPONSE_MESSAGES[:zombie_attack_zombie] if @user.infected && @opponent.infected
    return @response =  RESPONSE_MESSAGES[:human_attack_human]if !@user.infected && !@opponent.infected

    if @user.infected && @win ##zombie user bites human
      create_post(sprintf(POST_MESSAGES[:user_converts_H_to_Z][0], @user.name, @opponent.name), POST_MESSAGES[:user_converts_H_to_Z][1])
      update_user(@user.infected, 300)
      update_opponent(true)
      check_stats
      return @response = RESPONSE_MESSAGES[:user_converts_H_to_Z]
    elsif @user.infected && !@win ##zombie user misses human
      create_post(sprintf(POST_MESSAGES[:user_fail_converts_H_to_Z][0], @opponent.name, @user.name), POST_MESSAGES[:user_fail_converts_H_to_Z][1])
      update_opponent(@opponent.infected, 100)
      check_stats
      return @response = RESPONSE_MESSAGES[:user_fail_converts_H_to_Z]
    elsif @user.can_cure && @win ##human cures zombie
      create_post(sprintf(POST_MESSAGES[:successful_cure][0], @opponent.name, @user.name), POST_MESSAGES[:successful_cure][1])
      update_user(@user.infected, 500)
      update_opponent(false)
      check_stats
      return @response = RESPONSE_MESSAGES[:successful_cure]
    elsif @user.can_cure && !@win ##human fails zombie cure
      create_post(sprintf(POST_MESSAGES[:failed_cure][0], @user.name, @opponent.name), POST_MESSAGES[:failed_cure][1])
      create_post(sprintf(POST_MESSAGES[:new_zombie][0], @opponent.name, @user.name), POST_MESSAGES[:new_zombie][1])
      update_user(true)
      update_opponent(@opponent.infected, 100)
      check_stats
      return @response = RESPONSE_MESSAGES[:failed_cure]
    else ## user can't cure and loses
      create_post(sprintf(POST_MESSAGES[:failed_cure][0], @user.name, @opponent.name), POST_MESSAGES[:failed_cure][1])
      create_post(sprintf(POST_MESSAGES[:new_zombie][0], @opponent.name, @user.name), POST_MESSAGES[:new_zombie][1])
      update_user(true)
      update_opponent(@opponent.infected, 100)
      check_stats
      return @response = RESPONSE_MESSAGES[:no_cure_attempt]
    end
  end

  def create_post(body, title, audience = "both")
    Post.create(body: body, title: title, audience: audience)
  end

  def check_stats
    if Stats.all_human?
      p "ALLLL HUMMMANNNN SHOULD BE GAME OVER"
      @message = Message.human_messages.last
      create_post(@message[1], @message[0], "human")
      Game.end
    elsif Stats.all_zombie?
      p "ALLLLLL ZOMBIIEEEE SHOULD BE GAME OVER"
      @message = Message.zombie_messages.last
      create_post(@message[1], @message[0], "zombie")
      Game.end
    else
      p "REMAINING STATTTSSSSSSSSSSSSSS"
      remaining_stats(Stats.percent_zombies)
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
