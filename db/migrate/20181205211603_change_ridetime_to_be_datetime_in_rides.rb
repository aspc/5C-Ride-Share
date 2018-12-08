class ChangeRidetimeToBeDatetimeInRides < ActiveRecord::Migration
  def up
    change_column :rides, :ridetime, :datetime
  end

  def down
    change_column :rides, :ridetime, :time
  end
end
