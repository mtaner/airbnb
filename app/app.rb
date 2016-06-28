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
    p '======================2'
    p @spaces
    erb :'/spaces/index'
  end

  post '/myspaces' do
    # what is this space variable for
    space = Space.create(params)
p "====================1"
    p params
    redirect '/myspaces'
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

  run! if app_file == $0
end
