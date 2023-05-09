# lib/tasks/custom_seed.rake
namespace :missing_forms_mailer do
  task :send => :environment do

    # # all parents who have enrolled students
    parent_ids = Student.enrolled.pluck(:parent_id)
    parents = Parent.have_not_gotten_missing_forms_mail.where(id: parent_ids)

    parents.each do |p|
      ParentMailer.missing_forms_email(p).deliver_now
      Receipt.create(form_name: "Missing Forms", parent_id: p.id)
    end
  end
end
