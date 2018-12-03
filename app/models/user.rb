class User < ApplicationRecord
  before_create :confirmation_token

  include Gravtastic
  gravtastic :email
  has_one_attached :avatar
  has_many :follows, foreign_key: :followee
  # has_many :users, through: :follows, source: :follower  # what's this

  has_many :activity_participants
  has_many :activities, through: :activity_participants

  has_many :comments
  has_many :ratings

  has_many :user_locations

  has_many :photos

  before_save {self.email = email.downcase}

  validates :user_name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, presence: true, length: {minimum: 6}, allow_blank: true

  def self.get_one id
    User.find_by_id id
  end

  # current position of this user
  def current_position
    user_locations.order(created_at: :desc).first
  end

  def on_going_activity
    acitivities.where(status: 2)
  end

  scope :working, -> {
    joins(:activity_participants).joins(:activities).merge(Activity.working)
  }
  scope :active_position, -> {
    working.map(&:current_position)
  }

  def is_working
    on_going_activity.count > 1
  end

  def round_avatar
    avatar.variant()
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  private

  def confirmation_token
    if self.confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
