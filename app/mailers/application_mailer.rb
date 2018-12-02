class ApplicationMailer < ActionMailer::Base
  default from: 'workout.teamup@gmail.com'

  def welcome_email
    @user = params[:user]
    @activity =
    # @url = 'http://example.com/login'
    # mail(to: @user.email, subject: 'Welcome')
    mail(to: @user.email, subject: '[Workout Teamup] Welcome')
  end

  def reminder_email
    @user = params[:user]
    mail(to: @user.email, subject: '[Workout Teamup] Activity Reminder')
  end

  def material_design
    @user = params[:user]
    mail(to: @user.email, subject: '[Workout Teamup] Activity Reminder')
  end
end
