class CompetitionsController < ApplicationController
  def new
    @competition = Competition.create!(competition_params)
  end

  def index
    @competition = Competition.where(user: current_user)
    @competition = current_user.competition
  end

  def create
    render text: request.env['omniauth.auth'].to_yaml
  end

private

  def competition_params
    params.permit(:calories, :miles, :steps, :time)
  end
end
