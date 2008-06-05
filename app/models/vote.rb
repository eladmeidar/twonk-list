class Vote < ActiveRecord::Base
  belongs_to :twonk
  belongs_to :user
end
