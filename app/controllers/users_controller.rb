class UsersController < ApplicationController

  def index

  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:id] = @user.id
      cookies[:user_id] = { value: @user.id, expires: 6.days.from_now }


      if @user.should_be_infected ###TEST ONCE CREATE CONTROLLER WORKING
        @user.infected = true
        @user.save
      end
      redirect_to user_path(@user)
    else
      p "failed to create user"
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
    p @user.infected
    if @user.infected == true
      @events = Post.latest_zombie_posts
      p "zombie posts is" 
      stats = {humans: Stats.total_humans, zombies: Stats.total_zombies}
    elsif @user.infected == false
      @events = Post.latest_human_posts
      p "these are posts"
      p '-----------------------------'
      stats = {humans: Stats.total_humans, zombies: Stats.total_zombies}
    else
      flash[:error] = @user.errors.full_messages[0]
    end
    @html_content = render_to_string :partial => "event", :collection => @events
    render json:{"html_content" => @html_content, 'stats'=> stats}
  end


end


