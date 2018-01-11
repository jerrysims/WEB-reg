# Preview all emails at http://localhost:3000/rails/mailers/parent_mailer
class ParentMailerPreview < ActionMailer::Preview
  def shadow_schedule_email
    ParentMailer.shadow_schedule_email(Parent.first)
  end
end
