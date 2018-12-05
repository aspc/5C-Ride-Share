class AddIsAspcToRides < ActiveRecord::Migration
  def change
    add_column :rides, :is_aspc, :boolean
  end
end
