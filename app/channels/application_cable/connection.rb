module ApplicationCable
  class Connection < ActionCable::Connection::Base
    include SessionsHelper
    identified_by :current_user

    def connect
      self.current_user = current_user_action_cable
      if self.current_user.nil?
        # reject_unauthorized_connection
      end
    end
  end
end