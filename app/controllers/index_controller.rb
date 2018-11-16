class IndexController < ApplicationController
  def home
    @activities = Activity.all
  end

  def not_found
  end
end
