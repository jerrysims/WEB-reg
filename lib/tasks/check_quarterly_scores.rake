namespace :check do
  desc "Ensure QuarterlyScore records exist for each quarter's grade in registrations"
  task ensure_quarterly_scores: :environment do
    puts "Starting to check QuarterlyScore records..."

    Registration.find_each do |registration|
      next if registration.q1_grade.blank? && registration.q2_grade.blank? && registration.q3_grade.blank? && registration.q4_grade.blank?

      puts "Checking registration ID: #{registration.id}"

      if registration.q1_grade.present? && !QuarterlyScore.exists?(registration: registration, quarter: :q1)
        QuarterlyScore.create!(registration: registration, quarter: :q1, grade: registration.q1_grade)
        puts "Created QuarterlyScore for Q1 grade in registration ID: #{registration.id}"
      end

      if registration.q2_grade.present? && !QuarterlyScore.exists?(registration: registration, quarter: :q2)
        QuarterlyScore.create!(registration: registration, quarter: :q2, grade: registration.q2_grade)
        puts "Created QuarterlyScore for Q2 grade in registration ID: #{registration.id}"
      end

      if registration.q3_grade.present? && !QuarterlyScore.exists?(registration: registration, quarter: :q3)
        QuarterlyScore.create!(registration: registration, quarter: :q3, grade: registration.q3_grade)
        puts "Created QuarterlyScore for Q3 grade in registration ID: #{registration.id}"
      end

      if registration.q4_grade.present? && !QuarterlyScore.exists?(registration: registration, quarter: :q4)
        QuarterlyScore.create!(registration: registration, quarter: :q4, grade: registration.q4_grade)
        puts "Created QuarterlyScore for Q4 grade in registration ID: #{registration.id}"
      end
    end

    puts "Finished checking QuarterlyScore records."
  end
end
