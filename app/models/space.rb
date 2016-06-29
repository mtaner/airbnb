require 'data_mapper'
require 'dm-postgres-adapter'

class Space

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, String
  property :price, String
  property :start_date, Date, required: true
  property :end_date, Date, required: true

  belongs_to :user, required: false

end
