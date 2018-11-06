Rails.application.config.middleware.use OmniAuth::Builder do
  provider :strava, ENV['STRAVA_KEY'], ENV['STRAVA_SECRET'], {:provider_ignores_state => true}
  # known issue in Strava Oauth, but no work around at this time
end
