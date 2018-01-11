class ParentMailer < ApplicationMailer
  default from: 'notifications@webtutorialnashville.com'

  def shadow_schedule_email(parent)
    @parent = parent
    mail(to: @parent.email, subject: 'Your WEB Shadow Schedule')
  end
end
