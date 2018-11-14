class Competition < ApplicationRecord
  has_many :competition_users
  has_many :users, through: :competition_users
  has_many :stats
  
  def fetch_fitbit_data
    client = FitbitAPI::Client.new(
      client_id: ENV['FITBIT_KEY'],
      client_secret: ENV['FITBIT_SECRET'],
      access_token: users.first.fitbit_access_token,
      refresh_token: users.first.fitbit_refresh_token,
      expires_at: 31536000,
      user_id: users.first.fitbit_user_id
    )
    
    steps = client.activity_time_series("steps", start_date: start_date, end_date: end_date)
    calories = client.activity_time_series("calories", start_date: start_date, end_date: end_date)
    miles = client.activity_time_series("distance", start_date: start_date, end_date: end_date)

    prepped_stats = steps
      .pluck("value")
      .zip(calories.pluck("value"), miles.pluck("value"), steps.pluck("dateTime"))
      .map do |stats| 
        {steps: stats[0], calories: stats[1], miles: stats[2], recorded_at: stats[3]}
      end

    prepped_stats.each do |stat_data|
      stat = Stat.new(stat_data)
      stat.user = users.first
      stat.competition = self
      stat.skip_fetch = true
      stat.save!
    end
  end

  def fetch_strava_data
  end
end
