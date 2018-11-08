class FitbitController < ApplicationController
  def callback
    # Callback from Fitbit Oauth

    # Oauth Access Credentials
    
    current_user.fitbit_access_token = request.env['omniauth.auth']['credentials']['token']
    current_user.fitbit_refresh_token = request.env['omniauth.auth']['credentials']['refresh_token']
    current_user.fitbit_user_id = request.env['omniauth.auth']['uid']
    current_user.save!
    redirect_to user_path(current_user)
  end

  def start_activity
    client.activity_time_series(resource, opts={Competition.time})
  end

  private
      client = FitbitAPI::Client.new(client_id: ENV['FITBIT_KEY'],
                                 client_secret: ENV['FITBIT_SECRET'],
                                 access_token: current_user.fitbit_access_token,
                                 refresh_token: current_user.fitbit_refresh_token,
                                 expires_at: 31536000,
                                 user_id: current_user.fitbit_user_id)

# private
#   def get_user_activities(fitbit_data)
#     fitbit_user_id = fitbit_data["uid"]
#     user_secret = fitbit_data["credentials"]["secret"]
#     user_token = fitbit_data["credentials"]["token"]

#     # Store this information in you user model for

#     # logins in the future.

#     client = FitbitAPI::Client.new({
#       consumer_key: ENV['FITBIT_KEY'],
#       consumer_secret: ENV['FITBIT_SECRET'],
#       token: user_token,
#       secret: user_secret,
#       user_id: fitbit_user_id,
#     })

#     # Reconnects existing user using the information above

#     access_token = client.reconnect(user_token, user_secret)

#     # client.activities_on_date('2015-03-25') <- Specific Date

#     client.activities_on_date('today')
#   end
end
