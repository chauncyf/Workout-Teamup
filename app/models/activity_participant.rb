class ActivityParticipant < ApplicationRecord
  belongs_to :activity
  belongs_to :user, optional: true
end
