class UsersController < ApplicationController

  def index

  end

  def create
    p "======================================="
    p params
    p params[:user]
    @user = User.new(params[:user])
    p @user
    
    if @user.save
      session[:id] = @user.id
      p "created user!"

      if user.should_be_infected ###TEST ONCE CREATE CONTROLLER WORKING
        user.infected = true
        user.save
      end
      redirect_to user_path(@user)
    else
      p "failed to create user"
      redirect_to root_path
    end

  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def new
    @user = User.new
    render partial: "signup", :locals => { user: @user }
  end

end


