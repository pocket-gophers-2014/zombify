class UsersController < ApplicationController

  def index

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:id] = @user.id
      p "created user!"
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

end
