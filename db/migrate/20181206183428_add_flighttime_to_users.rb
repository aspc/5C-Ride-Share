class AddFlighttimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :flighttime, :datetime
  end
end
