require 'data_mapper'
require 'dm-postgres-adapter'

class Space

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, String
  property :price, String
  property :start_date, Date, required: false
  # property :end_date, Date, required: false

  # def start_date(start_date)
  #   p '====================3'
  # end

  belongs_to :user, required: false

end
