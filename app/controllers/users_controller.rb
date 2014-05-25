class UsersController < ApplicationController
  def index

  end

  def create
    @user = User.new(params[:user])

    if @user.save
      handle = @user.generate_handle
      @user.update_attributes(handle: handle)
      session[:id] = @user.id
      cookies[:user_id] = { value: @user.id, expires: 6.days.from_now }
      if @user.should_be_infected ###TEST ONCE CREATE CONTROLLER WORKING
        @user.infected = true
        @user.save
      end
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
    @user = User.find_by_id(params[:id])
    if @user.infected == true
      @events = Post.latest_zombie_posts
      stats = {humans: Stats.total_humans, zombies: Stats.total_zombies}
    elsif @user.infected == false
      @events = Post.latest_human_posts
      stats = {humans: Stats.total_humans, zombies: Stats.total_zombies}
    else
      flash[:error] = @user.errors.full_messages[0]
    end
    @html_content = render_to_string :partial => "event", :collection => @events
    render json:{"html_content" => @html_content, 'stats'=> stats}
  end

  def update
    @user = User.find(session[:id])
    p params
    p "*"*25
    @result = verify_results(params)
    p @result
    #render result of verifyResults method
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
    elsif @user.infected && @winner ## zombie user bites human
      ##create 2 new posts
      ##update both users
      ##update session?
      return @result = "Mmmmmm....Brainsssss.....You have added to the horde."
    elsif @user.infected && !@winner ##zombie user misses human
      #@user.update_attributes(infected: false)
      return @result = "You are feeling dizzy. The human has escaped. You still crave brains... "
    elsif @user_cure && @winner ##human cures zombie
      @opponent.update_attributes(infected: false)
      return @result = "You have successfully applied the cure!"
    elsif @user_cure && !@winner ##human fails zombie cure
      #@user.update_attributes(infected: true)
      return @result = "Your cure has failed. You feel your blood rising and crave delicious brains..."
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


