class ConfirmationMailerPreview < ActionMailer::Preview
  def registration_confirmation_email
    ConfirmationMailer.registration_confirmation_email(Parent.second, Invoice.first)
  end
end
