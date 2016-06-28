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

  run! if app_file == $0
end
