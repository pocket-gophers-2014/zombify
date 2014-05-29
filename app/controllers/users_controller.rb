class UsersController < ApplicationController
  def index
    if User.find_by_id(session[:id])
      @user = User.find(session[:id])
      redirect_to user_path(@user)
    end
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      handle = @user.generate_handle
      @user.update_attributes(handle: handle)
      session[:id] = @user.id
      # cookies[:user_id] = { value: @user.id, expires: 6.days.from_now }
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
    @user = User.find_by_id(session[:id])
    redirect_to root_path if @user != User.find(params[:id])
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
      opponents = "Humans Remaining: #{Stats.total_humans}"
    elsif @user.infected == false
      @events = Post.latest_human_posts
      opponents = "Zombies Remaining: #{Stats.total_zombies}"
    else
      flash[:error] = @user.errors.full_messages[0]
    end
    Post.delete_empty_posts(@events)
    @game = Game.current
    game_active = Game.current ? Game.current.game_active : false
    handle = "Code: #{@user.handle}"
    @html_content = render_to_string :partial => "event", :collection => @events
    game_over = render_to_string :partial => "games/end_game"
    render json:{"html_content" => @html_content,
                 "opponents" => opponents,
                 "points" => @user.points,
                 "handle" => handle,
                 "game_active" => game_active,
                 "game_over" => game_over,
                 "infected_state" => @user.infected.to_s,
                 "game_state" => @game.current_game_state}
  end

  def update
    if Game.pending?
      render partial: 'games/pending'
    elsif Game.completed?
      render partial: 'games/no_more_battling'
    else
      @user = User.find(session[:id])
      battle = Battle.new(params, @user)

      @results = battle.game_over ? battle.game_over : battle.response
      if battle.game_over
        Game.end
        render :json => {
          "end" => true,
          "attachment_partial" => render_to_string('battles/battle_results', :layout => false,  :locals => { result: @results })
        }
      else
        render partial: 'battles/battle_results', :locals => { result: @results }
      end
    end
  end
end





