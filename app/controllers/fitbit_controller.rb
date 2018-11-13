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


  def client
      client = FitbitAPI::Client.new(client_id: ENV['FITBIT_KEY'],
                                 client_secret: ENV['FITBIT_SECRET'],
                                 access_token: current_user.fitbit_access_token,
                                 refresh_token: current_user.fitbit_refresh_token,
                                 expires_at: 31536000,
                                 user_id: current_user.fitbit_user_id)
    end
end
