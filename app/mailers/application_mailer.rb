class ApplicationMailer < ActionMailer::Base
  default from: 'workout.teamup@gmail.com'

  def welcome_email
    @user = params[:user]
    # @url = 'http://example.com/login'
    # mail(to: @user.email, subject: 'Welcome')
    mail(to: @user.email, subject: 'Welcome to Workout Teamup')
  end

  # layout 'mailer'

end
