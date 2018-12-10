class Ride < ActiveRecord::Base
  has_many :rides_users
  has_many :users, :through => :rides_users
  has_many :comments, dependent: :destroy
  belongs_to :owner, :foreign_key => :owner_id, :class_name => 'User'

  accepts_nested_attributes_for :users
  attr_accessor :existing_aspc_ride

  validates :airport, :flighttime, :owner_id, :presence => true
  validate :is_aspc_valid

  def is_aspc_valid
    return unless is_aspc

    # Change these depending on the program date
    aspc_ride_start_date = Date.new(2018, 12, 17)
    aspc_ride_end_date = Date.new(2018, 12, 22)

    if not flighttime.to_date.between? aspc_ride_start_date, aspc_ride_end_date
      errors.add(:flighttime, "falls outside the range of the program (#{aspc_ride_start_date.strftime("%B %d, %Y") + " - " + aspc_ride_end_date.strftime("%B %d, %Y")})")
    end
  end
end
