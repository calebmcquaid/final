Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, ENV['FITBIT_KEY'], ENV['FITBIT_SECRET'], scope: 'activity location profile', provider_ignores_state: true
  # known issue in Strava Oauth, but no work around at this time
  provider :strava, ENV['STRAVA_KEY'], ENV['STRAVA_SECRET'], scope: 'read,read_all,activity:read_all', provider_ignores_state: true
end
