class Follow < ApplicationRecord
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'
  belongs_to :followee, foreign_key: :followee_id, class_name: 'User'

  #validates_uniqueness_of :followee_id, scope: :follower_id
end
