class CompetitionsController < ApplicationController
  def new
    @competition = Competition.new  
  end

  def index
    @competition = Competition.new  
  end

  def show
    @competition = Competition.find(params[:id])
  end

  def create
    @competition = Competition.new(competition_params)

    if @competition.save
      redirect_to competition_path(@competition)
    else
      flash[:errors] = @competition.errors.full_messages
      render :new
    end
  end
    # render text: request.env['omniauth.auth'].to_yaml

  def button
    # get API data to write to model
    @competition = Competition.create!(competition_params)
    # redirect_to url_for(:controller => :strava, :action => :callback)
  end

  def fetch_stats
    @stat = Stat.new
    @stat.user = current_user
    competition = Competition.find(params[:id])
    @stat.competition = competition
    @stat.save

    redirect_to competition_path(competition)
  end

private

  def competition_params
    params.permit(:calories, :miles, :steps, :start_date, :end_date, :competition)
  end
end
