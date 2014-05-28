
class Battle
  attr_reader :response

  def initialize(params, user)
    @user = user
    @opponent = determine_opponent(params["opponent"])
    @user_win = win?
    @response = calculate_results_and_respond
  end

  def game_over(end_game)
    end_game ? true : false
  end

  private

  def calculate_results_and_respond
    result = new Results(@user, @opponent, @user_win)
    result.response
    game_over(result.end_game)
  end

  def determine_opponent(opponent)
    handle = parse_opponent_id(opponent)
    User.find_by_handle(handle) || "invalid"
  end

  def parse_opponent_id(opponent)
    opponent_id = opponent.match(/=(.*)/)
    return $1
  end

  def human_chances
    Game.current.cure_found ? [8,1]: [8,6]
  end

  def calculate_win(human_win_ratio)
    rand(human_win_ratio[0]) > human_win_ratio[1] ? "human" : "zombie"
  end

  def win?
    winner = calculate_win(human_chances)
    user_state = @user.infected ? "human" : "zombie"
    user_state == winner ? true : false
  end
end


