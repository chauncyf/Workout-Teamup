class Activity < ApplicationRecord
  VALID_DATE_REGEX = /(0[1-9]|1[0-2])\/(0[1-9]|[12][0-9]|3[01])\/((20|)\d\d)\ |(((0[1-9]|1[0-2]|2[0-4]):[0-5][0-9])|(([1-9]|1[0-2]):[0-5][0-9]\ ([AP]M)))/i
  # mm/dd/(yy/yyyy) am or 24
  validates :activity_date, presence: true #, format: { with: VALID_DATE_REGEX }
  validates :place, presence: true
  validates :content, presence: true, length: {maximum: 140}

  has_many :activity_participants
  has_many :users, through: :activity_participants
  belongs_to :starter, foreign_key: :starter_id, class_name: "User"
  has_many :comments
  has_many :ratings

  has_many :tags, through: :activity_tags

  has_many :photos
  has_many :likes
  has_many :liked, through: :likes, source: "user"

  has_many :activity_contents

  def comments_list # comments ordered by time
    comments.order(created_at: :desc)
  end

  def get_participation_by_user_id user_id
    activity_participants.where(user_id: user_id)
  end

  scope :working, -> {where(status: 2)}

  def liked? user_id
    user_id && likes.where(user_id: user_id).size > 0
  end

end
