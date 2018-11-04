class IndexController < ApplicationController
  def home
    @activities = Activity.all
  end
end
