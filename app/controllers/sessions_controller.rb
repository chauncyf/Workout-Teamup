class SessionsController < ApplicationController
  # skip_before_action :require_login, only: [:new, :create]


  def new
    # unless request.xhr?
    #   not_found
    # end
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # UserMailer.with(user: user).confirmation_email.deliver_now
      if user.email_confirmed
        log_in user
        redirect_to root_url
      else
        flash[:danger] = 'Please activate your account by following the instructions in the account confirmation email'
        redirect_to login_path
      end

      # log_in user
      # redirect_to root_url
      # Log the user in and redirect to the user's show page.
    else
      # Create an error message.
      flash[:danger] = 'Invalid email/password combination' # Not quite right!
      # todo, refresh modal
      redirect_to login_path
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
