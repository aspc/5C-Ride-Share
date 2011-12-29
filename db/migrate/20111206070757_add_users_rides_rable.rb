class AddUsersRidesRable < ActiveRecord::Migration
  def up
    create_table :rides_users do |t|
      t.integer :ride_id
      t.integer :user_id
    end
  end

  def down
    drop_table :users_rides
  end
end
