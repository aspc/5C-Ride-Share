class AddOwnerToRides < ActiveRecord::Migration
  def change
    add_column :rides, :owner_id, :integer
  end
end
