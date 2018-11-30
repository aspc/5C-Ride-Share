class ChangeUsersTable < ActiveRecord::Migration
  def change
    remove_column :users, :fb_id
    remove_column :users, :clef_id
    remove_column :users, :fbimage
    remove_column :users, :fblink

    change_table :users do |t|
      t.boolean :is_cas_authenticated, null: false, default: false
      t.boolean :is_admin, default: false, null: false
      t.integer :school, default: 0, null: false
      t.string :password
    end
  end
end
