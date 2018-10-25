class Tag < ApplicationRecord
  has_many :activities, through: :activity_tags
end
