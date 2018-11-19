class SessionsController < ApplicationController
  include ApplicationHelper

  # skip_before_action :require_login, only: [:new, :create]


  def new
    unless request.xhr?
      not_found
    end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url
      # Log the user in and redirect to the user's show page.
    else
      # Create an error message.
      flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
      # todo, refresh modal
      # render 'new'

    end
  end

  def destroy
    # # render root_path
    # # render 'index/home'
    # render root_url
    log_out
    redirect_to root_url
  end

end
