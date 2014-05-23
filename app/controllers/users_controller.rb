class UsersController < ApplicationController

  def index

  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:id] = @user.id
      redirect_to user_path(@user)
    else
      render :text => @user.errors.full_messages.join(", "), :status => :unprocessable_entity
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
