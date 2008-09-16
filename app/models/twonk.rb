class Twonk < ActiveRecord::Base
  has_many :votes
  has_many :for_votes, :class_name => "Vote", :conditions => "positive = TRUE"
  has_many :against_votes, :class_name => "Vote", :conditions => "positive = FALSE"
  has_many :voters, :through => :votes, :source => :ip
  belongs_to :nominated_by, :class_name => "Ip", :counter_cache => "nomination_count"
  attr_accessible :name, :location
  validates_presence_of :name, :location
  validates_uniqueness_of :name, :scope => :location

  def to_s
    name
  end
end
