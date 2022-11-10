class RenameTerminalsToMaxRiders < ActiveRecord::Migration
  def up
    rename_column :rides, :terminal, :max_riders
  end

  def down
    rename_column :tasks, :max_riders, :terminal
  end
end
