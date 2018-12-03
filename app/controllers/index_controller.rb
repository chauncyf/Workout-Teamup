class IndexController < ApplicationController
  include SessionsHelper

  def home
    @activities = Activity.all
  end

  def not_found
  end
end
