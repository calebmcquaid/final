class Stat < ApplicationRecord
  before_create :fetch_fitbit_data, :fetch_strava_data
  belongs_to :competition
  belongs_to :user

  def skip_fetch=(val=false)
    @skip_fetch = val
  end

  def fetch_fitbit_data
    unless @skip_fetch
      puts "SOMETHING IS GOING WRONG"
      client = FitbitAPI::Client.new(
        client_id: ENV['FITBIT_KEY'],
        client_secret: ENV['FITBIT_SECRET'],
        access_token: user.fitbit_access_token,
        refresh_token: user.fitbit_refresh_token,
        expires_at: 30.days.from_now.to_i,
        user_id: user.fitbit_user_id
      )

      self.steps = client.daily_activity_summary["summary"]["steps"]
      self.calories = client.daily_activity_summary["summary"]["calories"]
      self.miles = client.daily_activity_summary["summary"]["distance"]
    end
  end

  def fetch_strava_data
    unless @skip_fetch
      puts "SOMETHING IS GOING WRONG"
      client = Strava::Api::V3::Client.new(
        client_id: ENV['STRAVA_KEY'],
        client_secret: ENV['STRAVA_SECRET'],
        token_type: 'Bearer',
        access_token: user.strava_access_token,
        refresh_token: user.strava_refresh_token,
        expires_at: 30.days.from_now.to_i,
        )

      # self.steps = 
    end
  end
end
