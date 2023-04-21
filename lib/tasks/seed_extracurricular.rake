# lib/tasks/invoices.rake
namespace :extracurricular do
  task :seed => :environment do
    fall = RegistrationPeriod.create(name: "2023-24 Fall Extracurricular", open_date: "2023-03-24", close_date: "2023-08-01", rp_type: "extracurricular")
    spring = RegistrationPeriod.create(name: "2023-24 Spring Extracurricular", open_date: "2023-03-24", close_date: "2023-08-01", rp_type: "extracurricular")
    product = Product.create(name: "Extracurricular Tuition", unit_price: 175, product_type: "extracurricular")

    CSV.foreach("public/2023_extracurriculars.csv") do |row|
      [fall, spring].each do |rp|
        c = Course.find_or_create_by(
          name: row[0],
          subject_area: row[1],
          division: row[2],
          teacher: row[3],
          description: row[4],
          grades: row[5],
          suggested_grade: row[6],
          registration_period_id: rp.id
        )
        s = Section.create(
          day: row[7],
          start_time: row[8],
          end_time: row[9],
          class_minimum: row[11],
          class_maximum: row[12],
          course_id: c.id
        )
        p = Product.find_or_create_by(
          name: "#{c.name} Fee",
          unit_price: row[10],
          product_type: "fee"
        )

        c.products << p
      end
    end
  end
end
