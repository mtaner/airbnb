require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'model/user'

DataMapper.setup(:default, "postgres://localhost/airbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
