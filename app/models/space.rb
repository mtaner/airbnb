
class Space

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, String
  property :price, String
  property :start_date, Date, required: false
  property :end_date, Date, required: false

end
