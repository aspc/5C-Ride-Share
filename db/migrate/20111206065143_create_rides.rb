class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :airport
      t.datetime :flighttime

      t.timestamps
    end
  end
end
