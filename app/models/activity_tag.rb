class ActivityTag < ApplicationRecord
  belongs_to :tag
  belongs_to :activity
end
