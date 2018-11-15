class Competition < ApplicationRecord
  has_many :competition_users
  has_many :users, through: :competition_users
  has_many :stats
  
  def fetch_fitbit_data
    users.each do |user|
      client = FitbitAPI::Client.new(
        client_id: ENV['FITBIT_KEY'],
        client_secret: ENV['FITBIT_SECRET'],
        access_token: user.fitbit_access_token,
        refresh_token: user.fitbit_refresh_token,
        expires_at: 30.days.from_now.to_i,
        user_id: user.fitbit_user_id
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
        expires_at: 30.days.from_now.to_i
        )

      miles = client.list_athlete_activities("distance", after: start_date, before: end_date)
      calories = (client.list_athlete_activities("distance", after: start_date, before: end_date)) * 100
      steps = ((client.list_athlete_activities("distance", after: start_date, before: end_date)) * 5280) / 2.3
      
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
  end
end

