require 'data_mapper'
require 'dm-postgres-adapter'
require 'bcrypt'

class User

  attr_reader :password
  attr_accessor :password_confirmation

  include DataMapper::Resource
  validates_uniqueness_of :email, message: "Email already exists."
  validates_confirmation_of :password

  property :id, Serial
  property :email, String, format: :email_address, required: true
  property :password_digest, String, length: 60

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)

    if user && (BCrypt::Password.new(user.password_digest) == password)
      user
    else
      nil
    end
  end



end
