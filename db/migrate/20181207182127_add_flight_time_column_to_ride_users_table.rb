class AddFlightTimeColumnToRideUsersTable < ActiveRecord::Migration
  def change
    add_column :rides_users, :flighttime, :datetime
    remove_column :users, :flighttime
  end
end
