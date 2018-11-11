class StravaController < ApplicationController
  def callback
    # Callback from Fitbit Oauth

    # Oauth Access Credentials
    current_user.strava_access_token = request.env['omniauth.auth']['credentials']['token']
    current_user.strava_refresh_token = request.env['omniauth.auth']['credentials']['refresh_token']
    current_user.save!
    redirect_to user_path(current_user)
  end
end
