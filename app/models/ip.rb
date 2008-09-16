class Ip < ActiveRecord::Base
  has_many :nominations, :class_name => "Twonk", :foreign_key => "nominated_by_id"
end
