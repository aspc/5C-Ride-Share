class AddRidetimeToRides < ActiveRecord::Migration
  def change
    add_column :rides, :ridetime, :datetime
  end
end
