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

  get '/signup' do
    erb(:'/users/signup')
  end

  post '/myspaces' do
    user = User.first(id: session[:user_id])
    params[:user] = user
    db_attempt(Space, params, 'myspaces/new')
  end

  post '/signup' do
    db_attempt(User, params, '/signup') do |user|
      session[:user_id] = user.id
    end
  end

  post '/requests/new' do
    params[:user_id] = session[:user_id]
    db_attempt(RequestSpace, params, '/myspaces') do |request| 
      flash.next[:request] = "Request has been sent for listing: '#{request.space.name}'"
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
      flash.next[:errors] = ['The email or password is incorrect']
      redirect('/sessions')
    end
  end

  get '/requests' do
    @requests_for_user = []
    Space.all(user_id: session[:user_id]).each do |space|
      @requests_for_user += RequestSpace.all( space: space )
    end
    @requests = RequestSpace.all(user_id: session[:user_id])
    erb(:'/requests/index')
  end

  get '/request' do
    @this_request = RequestSpace.first(id: params[:request_id])
    erb(:'/request/index')
  end

  post '/request/approval' do
    request = RequestSpace.first(id: params[:request_id])
    request.update(approved: !!params[:approval] )
    flash.next[:notice] = "#{request.space.name} #{(params[:approval] ? 'approved' : 'rejected')}"
    redirect("/request?request_id=#{params[:request_id]}")
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  def db_attempt(dm_class, params, failure_url, &block)
    db_entry = dm_class.new(params)
    if(db_entry.save)
      yield(db_entry) if block_given?
      redirect('/myspaces')
    else
      flash.next[:errors] = db_entry.errors.full_messages
      redirect(failure_url)
    end
  end

  run! if app_file == $0
end
