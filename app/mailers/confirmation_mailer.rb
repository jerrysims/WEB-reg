class ConfirmationMailer < ApplicationMailer
  default from: 'notifications@webtutorialnashville.com'

  def registration_confirmation_email(parent, invoice)
    @parent = parent
    @invoice = invoice

    mail(
      to: @parent.email,
      from: "notifications@webtutorialnashville.com",
      subject: 'WEB Registration Confirmation')
  end
end
