ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class AirBnb < Sinatra::Base
  get '/' do
    'Hello AirBnb!'
  end

  get '/signup' do
    erb(:signup)
  end

  post '/signup' do
    User.create(params)
    redirect('/signup-success')
  end

  get '/signup-success' do
    erb(:'signup-success')
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
