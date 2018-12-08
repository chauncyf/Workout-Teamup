class ApplicationMailer < ActionMailer::Base
  default from: 'Workout TeamUp <workout.teamup@gmail.com>'

  def confirmation_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Email Confirmation')
  end

  def reminder_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Activity Reminder')
  end
end
