class AddRideIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :ride_id, :integer
  end
end
