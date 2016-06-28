require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'models/space'


DataMapper.setup(:default, ENV['DATABASE_URL'] || "postgres://localhost/airbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
