class UsersController < ApplicationController

  def index

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:id] = @user.id
      redirect_to user_path(@user)
    else
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
