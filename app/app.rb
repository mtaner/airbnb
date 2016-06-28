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
    space = Space.create(params)
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
