module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
    cookies.encrypted[:user_id] = {
        value: user.id,
        expires: 1.year.from_now
    }
  end

  def current_user_action_cable
    User.get_one cookies.encrypted[:user_id]
  end

  # Returns the current logged-in user (if any).
  def current_user(id = session[:user_id])
    User.get_one id
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    flag = !current_user.nil?
    unless flag
      cookies.delete :user_id # delete the cookie for actioncable authorization
    end
    flag
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    cookies.delete :user_id
  end
end
