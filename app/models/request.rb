require 'data_mapper'
require 'dm-postgres-adapter'

class RequestSpace
  include DataMapper::Resource

  property :id, Serial
  property :requested_date, Date
  property :approved, Boolean, default: false


  belongs_to :user, required: true
  belongs_to :space, required: true

end
