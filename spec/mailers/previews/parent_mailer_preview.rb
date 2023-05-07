# Preview all emails at http://localhost:3000/rails/mailers/parent_mailer
class ParentMailerPreview < ActionMailer::Preview
  def shadow_schedule_email
    ParentMailer.shadow_schedule_email(Parent.first, Parent.first.students.first)
  end
  
  def missing_forms_email
    ParentMailer.missing_forms_email(Parent.find(9))
  end
end