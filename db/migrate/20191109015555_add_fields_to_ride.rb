class AddFieldsToRide < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :text
    add_column :rides, :max_riders, :integer
  end
end
