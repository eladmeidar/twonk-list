class Vote < ActiveRecord::Base
  belongs_to :twonk
  belongs_to :ip
  before_save :change_vote_count

  def change_vote_count
    (positive? ? twonk.increment!("votes_count") : twonk.decrement!("votes_count")) if positive_changed? || new_record?
  end
end
