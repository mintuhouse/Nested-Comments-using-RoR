class AddParentIdToMicroposts < ActiveRecord::Migration
  def self.up
    change_table :microposts do |m|
      m.integer :parent_id, :default => 0
    end
    #Micropost.update_all ["parent_id = ?", 0]
  end

  def self.down
    remove_column :microposts, :parent_id
  end
end
