require 'sinatra/base'
require_relative 'data_mapper_setup'

class AirBnb < Sinatra::Base

  enable :sessions
  set :sessions_secret, 'super secret'

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
    space = Space.create(property: params[:property])
    user = session[:user_id]
    redirect '/myspaces'
  end

  get '/signup' do
    erb(:'/users/signup')
  end

  post '/signup' do
    @user = User.new(params)
    if @user.save
      session[:user_id] = @user.id
      redirect('/myspaces')
    else
      puts "Email already exists"
    end
  end

  get '/login' do
    erb(:'/sessions/new')
  end

  run! if app_file == $0
end
