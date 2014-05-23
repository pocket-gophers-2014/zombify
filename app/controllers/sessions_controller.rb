class SessionsController < ApplicationController
  def new
    @user = User.new
    render partial: "users/login", :locals => { user: @user }
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to root_path
  end

end
