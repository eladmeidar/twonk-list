class CreateVotes < ActiveRecord::Migration
  def self.up
    create_table :votes do |t|
      t.references :twonk, :user
      t.text :comment
      t.boolean :positive, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :votes
  end
end
