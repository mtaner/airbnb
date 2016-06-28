require 'data_mapper'
require 'dm-postgres-adapter'

class User

  include DataMapper::Resource
  validates_uniqueness_of :email, message: "Email already exists."

  property :id, Serial
  property :email, String, format: :email_address, required: true
  property :password, String


end
