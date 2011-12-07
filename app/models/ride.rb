class Ride < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates :airport, :flighttime, :presence => true
end
