class Text < ActiveRecord::Base
  has_many :replies, dependent: :destroy
  has_one :weather_info
  geocoded_by :address
  after_validation :geocode
end
