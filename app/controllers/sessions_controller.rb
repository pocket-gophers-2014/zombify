class SessionsController < ApplicationController
  def new
    @user = User.new
    render partial: "users/login", :locals => { user: @user }
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      # cookies[:user_id] = { value: @user.id, expires: 6.days.from_now }
      redirect_to user_path(@user)
    else
      redirect_to root_path
    end
  end

  def destroy
    session.clear
    cookies.delete :user_id
    redirect_to root_path
  end

end
