class User < ApplicationRecord
  has_many :follows, foreign_key: :followee
  has_many :users, through: :follows, source: :follower

  has_many :acitivities, through: :activity_participants, foreign_key: :participant

  has_many :comments
  has_many :ratings

  has_many :user_locations

  has_many :photos

  before_save { self.email = email.downcase }

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }

end
