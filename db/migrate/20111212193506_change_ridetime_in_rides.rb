class ChangeRidetimeInRides < ActiveRecord::Migration
  def up
    change_table :rides do |t|
      t.change :ridetime, :time
    end
  end

  def down
    change_table :users do |t|
      t.change :ridetime, :time
    end
  end
end
