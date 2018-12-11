class IndexController < ApplicationController
  include SessionsHelper

  def home
    @activities = Activity.all
  end

  def not_found
  end

  def refresh
    page = params[:page]
    size = params[:size]
    @activities = Activity.all
    render 'refresh'
  end

  def refresh_profile
    profile_id = params[:profile_id]
    render 'refresh.js.erb'
  end
end
