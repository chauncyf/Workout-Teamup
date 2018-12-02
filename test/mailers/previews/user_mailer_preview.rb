# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def welcome_email
    UserMailer.with(user: User.first).welcome_email
  end

  def reminder_email
    UserMailer.with(user: User.first).reminder_email
  end

  def material_design
    UserMailer.with(user: User.first).material_design
  end
end
