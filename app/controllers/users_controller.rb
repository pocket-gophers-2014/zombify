class UsersController < ApplicationController
  def index
    if cookies[:user_id]
      @user = User.find(cookies[:user_id])
      redirect_to user_path(@user)
    end
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
      flash[:error] = @user.errors
      redirect_to root_path
    end

  end

  def show
    @user = User.find_by_id(params[:id])
    @human_stats = Stats.total_humans
    @zombie_stats = Stats.total_zombies
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
    @result = Results.new(params, @user).result
    render partial: 'battles/battle_results', :locals => { result: @result } #you are zombie.
  end
end



