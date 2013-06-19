class AddLoggedOutAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :logged_out_at, :datetime
  end
end
