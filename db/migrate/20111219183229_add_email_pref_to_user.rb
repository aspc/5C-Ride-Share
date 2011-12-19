class AddEmailPrefToUser < ActiveRecord::Migration
  def change
    add_column :users, :email_pref, :boolean
  end
end
