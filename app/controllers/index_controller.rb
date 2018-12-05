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
end
