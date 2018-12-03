class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper

  # before_action :require_login
  # include ApplicationHelper
  # def require_login
  #   if !logged_in?
  #     redirect_to login_path
  #   end
  # end

end
