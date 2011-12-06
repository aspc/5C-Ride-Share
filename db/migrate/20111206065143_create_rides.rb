class CreateRides < ActiveRecord::Migration
  def change
    create_table :rides do |t|
      t.string :airport
      t.date :date
      t.time :time

      t.timestamps
    end
  end
end
