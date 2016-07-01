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
    db_try_entry(Space, params, '/myspaces', '/myspaces/new')
  end

  get '/signup' do
    erb(:'/users/signup')
  end

  post '/signup' do
    db_try_entry(User, params, '/myspaces', '/signup') do |user|
      session[:user_id] = user.id
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
    db_try_entry(RequestSpace, params, '/myspaces', '/myspaces') do |request|
      flash.next[:request] = "Request has been sent for listing: '#{request.space.name}'"
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

  def db_try_entry(dm_class, params, success_route, failure_route, &block)
    item = dm_class.new(params)
    if item.save
      yield(item) if block_given?
      redirect(success_route)
    else
      flash.next[:errors] = item.errors.full_messages
      redirect(failure_route)
    end
  end
      

  run! if app_file == $0
end
