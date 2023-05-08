# lib/tasks/custom_seed.rake
namespace :missing_forms_mailer do
  task :send => :environment do

    # # all parents who have enrolled students
    parent_ids = Student.enrolled.pluck(:parent_id)
    parents = Parent.find(parent_ids)

    parents.each do |p|
      ParentMailer.missing_forms_email(p).deliver_now
    end
  end
end
