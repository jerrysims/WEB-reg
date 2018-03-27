# lib/tasks/invoices.rake
namespace :invoice do
  task :initial => :environment do
    ARGV.each { |a| task a.to_sym do ; end }

    month, day, year = ARGV[1].split('/')
    date = Date.new(year.to_i, month.to_i, day.to_i)
    invoices = Invoice.where(created_at: date..(date+1.day))
    invoices_csv_data = ""

    invoices.each do |i|
      invoices_csv_data += i.write_to_csv
    end

    InitialInvoiceMailer.initial_invoice_email(date, invoices_csv_data).deliver_now      
  end
end
