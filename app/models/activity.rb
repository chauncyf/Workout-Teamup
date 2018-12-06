class Activity < ApplicationRecord
  validates :place, :activity_date, presence: true



  has_many :activity_participants
  has_many :users, through: :activity_participants

  has_many :comments
  has_many :ratings

  has_many :tags, through: :activity_tags

  has_many :photos

  has_many :activity_contents

  def commentsList # comments ordered by time
    comments.order(created_at: :desc)
  end

  def get_participation_by_user_id user_id
    activity_participants.where(user_id: user_id)
  end

  scope :working, -> { where(status: 2) }

end
