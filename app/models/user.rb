class User < ApplicationRecord
  has_one_attached :avatar
  has_many :follows, foreign_key: :followee
  # has_many :users, through: :follows, source: :follower  # what's this

  has_many :activity_participants
  has_many :activities, through: :activity_participants

  has_many :comments
  has_many :ratings

  has_many :user_locations

  has_many :photos

  before_save { self.email = email.downcase }

  validates :user_name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }


  # current position of this user
  def currentPosition
    user_locations.order(created_at: :desc).first
  end

  def onGoingActivity
    acitivities.where(status: 2)
  end

  def isWorking
    onGoingActivity.count > 1;
  end

  def averageRatings
    ratings
  end

end
