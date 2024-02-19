# lib/tasks/copy_grades.rake
namespace :grades do
  task :copy => :environment do
    # For each registration 
    Registration.all.each do |r|
    # unless all grade attributes are nil
      if r.q1_grade || r.q2_grade || r.q3_grade || r.q4_grade
        Grade.create(section: r.section, student: r.student, q1: r.q1_grade, q2: r.q2_grade, q3: r.q3_grade, q4: r.q4_grade)
      end
    end
  end
end
