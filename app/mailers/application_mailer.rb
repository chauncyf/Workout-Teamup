class ApplicationMailer < ActionMailer::Base
  default from: 'workout.teamup@gmail.com'

  def confirmation_email
    @user = params[:user]
    mail(to: @user.email, subject: '[Workout Teamup] Email Confirmation')
  end

  def reminder_email
    @user = params[:user]
    mail(to: @user.email, subject: '[Workout Teamup] Activity Reminder')
  end
end
