class User < ApplicationRecord
  has_many :follows, foreign_key: :followee
  has_many :users, through: :follows, source: :follower

  has_many :acitivities, through: :activity_participants, foreign_key: :participant

  has_many :comments
  has_many :ratings

  has_many :user_locations

  has_many :photos
end
