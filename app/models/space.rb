require 'data_mapper'
require 'dm-postgres-adapter'
require 'dm-validations'

class Space

  include DataMapper::Resource

  property :id, Serial
  property :name, String
  property :description, String
  property :price, String
  property :start_date, Date, required: true
  property :end_date, Date, required: true

  belongs_to :user, required: false

  validates_with_method :start_date, method: :date_in_future?
  validates_with_method :end_date, method: :end_after_start?

  def date_in_future?
    return [false, 'Must be valid date'] unless @start_date.is_a?(Date)
    @start_date >= DateTime.now ? true : [false, 'start date is in the past']
  end

  def end_after_start?
    return [false, 'Must be valid date'] unless @end_date.is_a?(Date) && @start_date.is_a?(Date)
    @end_date > @start_date ? true : [false, 'End date must be after start date']
  end
  
  def date_check(start_date, end_date)
    end_date > start_date if Time.parse(start_date) >= Time.now
  end

end
