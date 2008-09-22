class AddAcceptedToTwonks < ActiveRecord::Migration
  def self.up
    add_column :twonks, :accepted, :boolean, :default => false
  end

  def self.down
    remove_column :twonks, :accepted
  end
end
