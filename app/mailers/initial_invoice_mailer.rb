class InitialInvoiceMailer < ApplicationMailer
  default from: 'notifications@webtutorialnashville.com'

  def initial_invoice_email(date, csv_data)
    @date = date
    attachments["initial_invoices_#{date.strftime("%Y%m%d")}"] = { mime_type: 'text/csv', content: csv_data }

    mail(
      to: 'jerrysims07@gmail.com',
      cc: ['webtutorial2013@gmail.com', 'becky.gore1@gmail.com' ],
      from: "notifications@webtutorialnashville.com",
      subject: "Initial Invoice Export - #{date.strftime('%Y%m%d')}"
    )
  end
end
