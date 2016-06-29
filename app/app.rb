ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class AirBnb < Sinatra::Base
  register Sinatra::Flash
  
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
    # what is this space variable for - you could just have Space.create(safe_params(params))
    @space = Space.new(safe_params(params))
    if @space.save
      redirect '/myspaces'
    else
      flash.next[:errors] = @space.errors.full_messages
      redirect 'myspaces/new'
    end
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

  def safe_params(params)
    {name: params[:name],
    price: params[:price],
    description: params[:description],
    start_date: params[:start_date]}
  end

  run! if app_file == $0
end
