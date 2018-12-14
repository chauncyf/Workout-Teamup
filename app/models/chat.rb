class Chat < ApplicationRecord
  belongs_to :sender, foreign_key: :send_from, class_name: 'User'
  belongs_to :receiver, foreign_key: :send_to, class_name: 'User'

  scope :not_sent, -> {where(status: 0)}
  scope :sent, -> {where(status: 1)}

end
