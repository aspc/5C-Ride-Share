class Ride < ActiveRecord::Base
  has_many :rides_users
  has_many :users, :through => :rides_users
  accepts_nested_attributes_for :users, allow_destroy: true

  has_many :comments, dependent: :destroy

  attr_accessor :existing_aspc_ride

  validates :airport, :flighttime, :presence => true
end
