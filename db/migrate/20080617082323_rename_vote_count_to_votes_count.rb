class RenameVoteCountToVotesCount < ActiveRecord::Migration
  def self.up
    rename_column :twonks, :vote_count, :votes_count
  end

  def self.down
    rename_column :twonks, :votes_count, :vote_count
  end
end
