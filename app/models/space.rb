
class Space

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, String
  property :price, String

  belongs_to :user, required: false

end
