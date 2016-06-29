require 'data_mapper'
require './app/app.rb'

namespace :db do
  desc "Non destructive upgrade"
  task :auto_upgrade do
    ENV['RACK_ENV'] = 'development'
    DataMapper.auto_upgrade!
    ENV['RACK_ENV'] = 'test'
    DataMapper.auto_upgrade!
    puts "Auto-upgrade complete (no data loss)"
  end
  desc "Destructive upgrade"
  task :auto_migrate do
    ENV['RACK_ENV'] = 'development'
    DataMapper.auto_migrate!
    ENV['RACK_ENV'] = 'test'
    DataMapper.auto_migrate!
    puts "Auto-migrate complete (data was lost)"
  end
end
