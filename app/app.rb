ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'

class AirBnb < Sinatra::Base
  register Sinatra::Flash
  use Rack::MethodOverride

  enable :sessions
  set :sessions_secret, 'super secret'

  get '/' do
    redirect('/signup')
  end

  get '/myspaces/new' do
    erb :'spaces/new'
  end

  get '/myspaces' do
    @spaces = Space.all
    erb :'/spaces/index'
  end

  post '/myspaces' do
    user = User.first(id: session[:user_id])
    params[:user] = user
    @space = Space.new(params)
    if @space.save && @space.date_check(params[:start_date], params[:end_date])
      redirect '/myspaces'
    else
      if !@space.errors.full_messages.empty?
        flash.next[:errors] = @space.errors.full_messages
      else
        flash.keep[:notice] = 'End date must be after start date or the start date is in the past'
      end
      redirect 'myspaces/new'
    end
  end

  get '/signup' do
    erb(:'/users/signup')
  end

  post '/signup' do
    user = User.new(params)
    if user.save
      session[:user_id] = user.id
      redirect('/myspaces')
    else
      flash.next[:errors] = user.errors.full_messages
      redirect('/signup')
    end
  end

  get '/sessions' do
    erb(:'/sessions/new')
  end

  delete '/sessions' do
    session.clear
    flash.next[:notice] = 'You have signed out'
    redirect '/'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect('/myspaces')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb(:'/sessions/new')
    end
  end

  post '/requests/new' do
    params[:user_id] = session[:user_id]
    request = RequestSpace.create(params)
    if request.save
      flash.next[:request] = "Request has been sent for listing: '#{request.space.name}'"
      redirect('/myspaces')
    else
      flash.next[:errors] = request.errors.full_messages
      redirect('/myspaces')
    end
  end

  get '/requests' do
    @requests = RequestSpace.all
    erb(:'/requests/index')
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  run! if app_file == $0
end
