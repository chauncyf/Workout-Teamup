class Activity < ApplicationRecord
  has_many :users, through: :activity_participants

  has_many :comments
  has_many :ratings

  has_many :tags, through: :activity_tags

  has_many :photos

  def commentsList # comments ordered by time
    comments.order(created_at: :desc)
  end

end
