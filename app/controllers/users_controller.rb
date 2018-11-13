class UsersController < ApplicationController
  def index
    redirect_to( user_path, alert: "This is an admin function.") unless current_user.admin?
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def current_user_home
    redirect_to current_user
  end

  def create
   @user = User.new(params[:user][:name][:email])
    if @user.save
     redirect_to @user, alert: "User created successfully."
    else
     redirect_to new_user_path, alert: "Error creating user."
    end
  end

  def current_user_home
    redirect_to current_user
  end

  def fetch_stats
    @stat = Stat.new
    @stat.user = current_user
    competition = Competition.find(params[:id])
    @stat.competition = competition
    @stat.save
  end
end
