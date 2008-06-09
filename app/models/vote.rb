class Vote < ActiveRecord::Base
  belongs_to :twonk
  belongs_to :user
#  acts_as_snook :author_field => :user, :body_field => :comment

  def url

  end
end
