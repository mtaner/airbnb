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
    refactor_try(Space, params, 'myspaces/new')
#    @space = Space.new(params)
#    if @space.save
#      redirect '/myspaces'
#    else
#      flash.next[:errors] = @space.errors.full_messages
#      redirect 'myspaces/new'
#    end
  end

  post '/signup' do
    refactor_try(User, params, '/signup') do |user|
      session[:user_id] = user.id
    end
#    user = User.new(params)
#    if user.save
#      session[:user_id] = user.id
#      redirect('/myspaces')
#    else
 #     flash.next[:errors] = user.errors.full_messages
 #     redirect('/signup')
 #   end
  end

  post '/requests/new' do
    params[:user_id] = session[:user_id]
    refactor_try(RequestSpace, params, '/myspaces') do |request| 
      flash.next[:request] = "Request has been sent for listing: '#{request.space.name}'"
    end
#    request = RequestSpace.new(params)
#    if request.save
#      flash.next[:request] = "Request has been sent for listing: '#{request.space.name}'"
#      redirect('/myspaces')
#    else
#      flash.next[:errors] = request.errors.full_messages
#      redirect('/myspaces')
#    end
  end

  def refactor_try(dm_class, params, failed_redirect, &block)
    something = dm_class.new(params)
    if(something.save)
      yield(something) if block_given?
      redirect('/myspaces')
    else
      flash.next[:errors] = something.errors.full_messages
      redirect(failed_redirect)
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

  run! if app_file == $0
end
