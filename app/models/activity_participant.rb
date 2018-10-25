class ActivityParticipant < ApplicationRecord
  belongs_to :participant, class: :User
  belongs_to :activity
end
