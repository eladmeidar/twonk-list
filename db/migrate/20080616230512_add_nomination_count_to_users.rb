class AddNominationCountToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :nomination_count, :integer
  end

  def self.down
    remove_column :users, :nomination_count
  end
end
