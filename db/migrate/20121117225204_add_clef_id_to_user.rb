class AddClefIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :clef_id, :string
  end
end
