class CreateIps < ActiveRecord::Migration
  def self.up
    # drop_table :users
    # create_table :ips do |t|
    #     t.integer :nomination_count, :default => 0
    #     t.string :ip
    #   end
    rename_column :votes, :user_id, :ip_id
  end

  def self.down
    drop_table :ips
    create_table :users do |t|
    end
  end
end
