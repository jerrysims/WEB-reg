namespace :migrate do
  desc "Move grades from Registration to QuarterlyScore"
  task move_grades: :environment do
    Registration.find_each do |registration|
      QuarterlyScore.create!(registration: registration, quarter: :q1, grade: registration.q1_grade) if registration.q1_grade.present?
      QuarterlyScore.create!(registration: registration, quarter: :q2, grade: registration.q2_grade) if registration.q2_grade.present?
      QuarterlyScore.create!(registration: registration, quarter: :q3, grade: registration.q3_grade) if registration.q3_grade.present?
      QuarterlyScore.create!(registration: registration, quarter: :q4, grade: registration.q4_grade) if registration.q4_grade.present?
    end
  end
end
