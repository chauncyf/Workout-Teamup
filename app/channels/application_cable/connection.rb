module ApplicationCable
  class Connection < ActionCable::Connection::Base
=begin
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
    def find_verified_user
      # we need to have a user model here
      if verified_user = User.find_by(id: cookies.encrypted[:user_id])
        verified_user
      else
        reject_unauthorized_connection
      end
    end
=end
  end
end