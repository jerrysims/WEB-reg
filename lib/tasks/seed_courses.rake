# lib/tasks/invoices.rake
namespace :courses do
  task :seed => :environment do
    rp = RegistrationPeriod.create(name: "2023-24 Academic Year", open_date: "2023-03-06", close_date: "2023-08-01")

    CSV.foreach("public/2023_registration_data.csv") do |row|
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
      puts "row[2] = #{row[2]}... course.division = #{c.division}"
    end
  end
end

namespace :products do
  task :seed => :environment do
    CSV.foreach("public/2023_products.csv") do |row|
      Product.find_or_create_by(
        name: row[0],
        unit_price: row[1],
        product_type: row[2]
      )
    end
  end
end
