class FitbitController < ApplicationController
  def callback
    fitbit_data  = request.env['omniauth.auth']
  end

  def make_request
    @client = FitbitAPI::Client.new(client_id: ENV['FITBIT_KEY'],
                                    client_secret: ENV['FITBIT_SECRET'],
                                    redirect_uri: 'http://localhost:3000/auth/fitbit/callback')
  end
end
