class Stat < ApplicationRecord
  before_create :fetch_data
  belongs_to :competition
  belongs_to :user

  def fetch_data
    client = FitbitAPI::Client.new(
      client_id: ENV['FITBIT_KEY'],
     client_secret: ENV['FITBIT_SECRET'],
     access_token: user.fitbit_access_token,
     refresh_token: user.fitbit_refresh_token,
     expires_at: 31536000,
     user_id: user.fitbit_user_id
    )

    self.steps = client.daily_activity_summary["summary"]["steps"]
  end
end
