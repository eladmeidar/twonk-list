class CreateTwonks < ActiveRecord::Migration
  def self.up
    create_table :twonks do |t|
      t.string :name, :location
      t.references :nominated_by
      t.integer :vote_count, :default => 1
      t.timestamps
    end
  end

  def self.down
    drop_table :twonks
  end
end
