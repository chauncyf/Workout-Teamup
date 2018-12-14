class IndexController < ApplicationController
  include SessionsHelper
  include ActivitiesHelper

  def home
    @activities = get_activities size: 20, page: 1
  end

  def not_found
  end

  def refresh
    @activities = get_activities params
    render 'refresh'
  end
end
