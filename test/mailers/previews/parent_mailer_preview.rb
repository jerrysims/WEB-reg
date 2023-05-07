class ParentMailerPreview < ActionMailer::Preview
  def missing_forms_email
    ParentMailer.with(parent: current_parent).missing_forms_email(current_parent)
  end
end