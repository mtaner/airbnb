require 'sinatra/base'
require_relative 'data_mapper_setup'


class AirBnb < Sinatra::Base
  get '/' do
    'Hello AirBnb!'
  end

  get '/myspaces/new' do
    erb :'spaces/new'
  end

  get '/myspaces' do
    @spaces = Space.all
    erb :'/spaces/index'
  end

  post '/myspaces' do

  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
