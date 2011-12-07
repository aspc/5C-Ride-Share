class AddFbimageAndFblinkToUser < ActiveRecord::Migration
  def change
    add_column :users, :fbimage, :string
    add_column :users, :fblink, :string
  end
end
