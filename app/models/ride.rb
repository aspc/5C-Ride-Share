class Ride < ActiveRecord::Base
  has_and_belongs_to_many :users
  accepts_nested_attributes_for :users, allow_destroy: true

  validates :airport, :flighttime, :presence => true
end
