
class Battle
  attr_reader :response, :game_over

  def initialize(params, user)
    @user = user
    @opponent = determine_opponent(params["opponent"])
    @user_win = win?
    @response = calculate_results_and_respond
    @game_over = false
  end

  def end_game?(end_game)
    @game_over = end_game ? true : false
    Game.end if @game_over
  end


  private

  def calculate_results_and_respond
    result = Results.new(@user, @opponent, @user_win)
    end_game?(result.end_game)
    result.response
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
    Game.current.cure_found ? [8,6]: [8,2]
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


