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
    p params
    @user = User.find(session[:id])
    @result = Results.new(params, @user)
    @results = @result.end_game ? @result.end_game : @result.result
    if @result.end_game
      Game.current.update_attributes(game_active: false)
      render :json => {
        "end" => true,
        "attachment_partial" => render_to_string('battles/battle_results', :layout => false,  :locals => { result: @results })
      }
    else
      render partial: 'battles/battle_results', :locals => { result: @results }
    end
  end
end



