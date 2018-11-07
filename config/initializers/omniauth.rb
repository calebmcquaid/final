Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fitbit, ENV['FITBIT_KEY'], ENV['FITBIT_SECRET'], {:provider_ignores_state => true}
  # known issue in Strava Oauth, but no work around at this time
end
