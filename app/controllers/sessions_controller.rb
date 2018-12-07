class SessionsController < ApplicationController
  # skip_before_action :require_login, only: [:new, :create]


  def new
    @user = User.new
    # @user = User.find_by(email: params[:session][:email].downcase)


    # unless request.xhr?
    #   not_found
    # end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    @invalid_key = false
    respond_to do |format|
      if @user && @user.authenticate(params[:session][:password])
        # UserMailer.with(user: user).confirmation_email.deliver_now
        if @user.email_confirmed
          log_in @user
          format.html {redirect_to root_url}
        else
          flash[:danger] = 'Please activate your account by following the instructions in the account confirmation email'
          format.html {redirect_to login_path}
        end

        # log_in user
        # redirect_to root_url
        # Log the user in and redirect to the user's show page.
      else
        @invalid_key = true
        format.html {render :new}
        format.json {render json: @invalid_key, status: :unprocessable_entity}
        format.js   {render layout: false, content_type: 'text/javascript' }
      end
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
