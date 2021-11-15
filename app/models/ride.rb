class Ride < ActiveRecord::Base
  has_many :rides_users
  has_many :users, :through => :rides_users
  has_many :comments, dependent: :destroy
  belongs_to :owner, :foreign_key => :owner_id, :class_name => 'User'

  accepts_nested_attributes_for :users
  attr_accessor :existing_aspc_ride

  validates :airport, :flighttime, :owner_id, :terminal, :presence => true
  validate :is_flighttime_valid
  validate :is_aspc_valid

  def is_flighttime_valid
    return unless flighttime

    if flighttime < Time.now
      errors.add(:flighttime, "cannot be in the past")
    end
  end

  def is_aspc_valid
    return unless is_aspc

    # Change these depending on the program date
    # TODO: set this in admin panel
    aspc_ride_start_date = Date.new(2021, 12, 13)
    aspc_ride_end_date = Date.new(2021, 12, 18)

    if not flighttime.to_date.between? aspc_ride_start_date, aspc_ride_end_date
      errors.add(:flighttime, "falls outside the range of the program dates (#{aspc_ride_start_date.strftime("%B %d, %Y") + " - " + aspc_ride_end_date.strftime("%B %d, %Y")})")
    end

    users.each do |user|
      if Ride.joins(:users)
             .where(:is_aspc => true, :flighttime => aspc_ride_start_date..aspc_ride_end_date, :users => {:id => user.id})
             .count > 0

        errors.add(:users, "cannot join more than one ASPC funded ride at a time")
        break
      end
    end
  end
end
