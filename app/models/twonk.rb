class Twonk < ActiveRecord::Base
  has_many :votes
  has_many :voters, :through => :votes, :source => :user
  validates_presence_of :name, :location
  def self.most_twonky
    find(:all, :order => "vote_count")
  end

  def for_votes
    votes.select { |vote| vote.positive? }
  end

  def against_votes
    votes.select { |vote| !vote.positive? }
  end
end
