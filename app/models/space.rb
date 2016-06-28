
class Space

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, String
  property :price, String
  property :start_date, Date
  property :end_date, Date

  validates_format_of :start_date, as: Date
  validates_format_of :end_date, as: Date
end
