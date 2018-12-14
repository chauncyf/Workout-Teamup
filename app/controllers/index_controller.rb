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
    if params[:type].blank?
      @activities = Activity.all
    else
      @activities = Activity.where(:type => params[:type])
    end
    render 'refresh'
  end
end
