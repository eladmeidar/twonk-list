class Vote < ActiveRecord::Base
  belongs_to :twonk
  belongs_to :user, :counter_cache => "nomination_count"
#  acts_as_snook :author_field => :user, :body_field => :comment
  
  before_save :change_vote_count

  def change_vote_count
    (positive? ? twonk.increment!("votes_count") : twonk.decrement!("votes_count")) if positive_changed? || new_record?
  end

  def url

  end
end
