# lib/tasks/invoices.rake
namespace :teachers do
  task :seed => :environment do
    rp = RegistrationPeriod.find_by(name: "2024-25 Academic Year", rp_type: "academic")

    CSV.foreach("public/2024_registration_data.csv") do |row|
      c = Course.find_by(
        name: row[2],
      )
      
      if s = Section.find_by( day: row[11], start_time: row[12], course_id: c.id)
        if t = Teacher.find_by(email: row[1])
          TeachersSection.create(teacher_id: t.id, section_id: s.id)
        end
      end
    end
  end
end