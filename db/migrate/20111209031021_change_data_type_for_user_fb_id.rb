class ChangeDataTypeForUserFbId < ActiveRecord::Migration
  def up
    change_table :users do |t|
      t.change :fb_id, :string
    end
  end

  def down
    change_table :users do |t|
      t.change :fb_id, :integer
    end
  end
end
