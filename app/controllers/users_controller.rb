class UsersController < ApplicationController

  def index

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      handle = @user.generate_handle
      @user.update_attributes(handle: handle)
      session[:id] = @user.id
      p "created user!"
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by_id(params[:id])
    @events = @user.infected ? Post.latest_zombie_posts : Post.latest_human_posts
  end

  def new
    @user = User.new
    render partial: "signup", :locals => { user: @user }
  end

  def edit

  end

  def update
    @user = User.find(session[:id])
    @result = verify_results(params)
    render partial: 'battles/battle_results', :locals => { result: @result } #you are zombie.
  end

  private

  def verify_results(params)
    @winner = eval_string(params["result"])
    handle = parse_opponent_id(params["opponent"])
    @opponent = User.find_by_handle(handle) || "invalid"
    return @result = "invalid user code" if @opponent == "invalid" 
    @user = User.find(session[:id])
    return @result = "Bite yourself all you want, I guess..." if @opponent == @user
    if @user.infected && @opponent.infected
      return @result = "Why are you biting each other, Children?"
    elsif !@user.infected && !@opponent.infected
      return @result = "Why are you wasting precious cures?!"
    elsif @user.infected && @winner ##zombie user bites human
      ##create 2 new posts, one with zombie audience, one with human audience
      ##update both users if they have earned points
      ##update people's secret codes?
      ##update session?
      ##check the conditonals in the rest of the game logic
      ##return text to render to the battle result page
      return @result = "Mmmmmm....Brainsssss.....You have added to the horde."
    elsif @user.infected && !@winner ##zombie user misses human
      #@user.update_attributes(infected: false)
      return @result = "You are feeling dizzy. The human has escaped. You still crave brains... " 
    elsif @user.can_cure && @winner ##human cures zombie
      #@opponent.update_attributes(infected: false)
      return @result = "You have successfully applied the cure!" 
    elsif @user.can_cure && !@winner ##human fails zombie cure
      #@user.update_attributes(infected: true)
      return @result = "Your cure has failed. You feel your blood rising and crave delicious brains..."
    elsif @user.can_cure == false
      return @result = "You do not have the cure! What are you doing!?"
    else      
      return @result = "Something has gone wrong."
    end

  end

  def parse_opponent_id(opponent)
    opponent_id = opponent.match(/=(.*)/)
    return $1
  end

  def eval_string(boolean_string)
    boolean_string == 'true'
  end


end
