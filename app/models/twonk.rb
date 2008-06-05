class Twonk < ActiveRecord::Base
  has_many :votes
  has_many :voters, :through => :votes, :as => :voter
  validates_presence_of :name, :location
  def self.most_twonky
    find(:all, :order => "vote_count")
  end
end
