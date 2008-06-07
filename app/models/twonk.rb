class Twonk < ActiveRecord::Base
  has_many :votes
  has_many :for_votes, :class_name => "Vote", :conditions => "positive = 't'"
  has_many :against_votes, :class_name => "Vote", :conditions => "positive = 'f'"
  has_many :voters, :through => :votes, :source => :user
  validates_presence_of :name, :location
  validates_uniqueness_of :name, :scope => :location
  def self.most_twonky
    find(:all, :order => "vote_count")
  end

end
