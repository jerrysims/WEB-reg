# lib/tasks/invoices.rake
namespace :courses_2024 do
  task :seed => :environment do
    rp = RegistrationPeriod.find_by(name: "2024-25 Academic Year")

    if rp.nil?
      rp = RegistrationPeriod.create(name: "2024-25 Academic Year", open_date: "2024-03-04", close_date: "2024-08-01", rp_type: "academic")
    end
    CSV.foreach("public/2024_registration_data.csv") do |row|
      c = Course.find_or_create_by(
        name: row[2],
        subject_area: row[4],
        division: row[5],
        description: row[7],
        grades: row[9],
        suggested_grade: row[10],
        registration_period_id: rp.id
      )
      s = Section.create(
        day: row[11],
        start_time: row[12],
        end_time: row[13],
        class_minimum: row[15],
        class_maximum: row[16],
        course_id: c.id
      )
      p = Product.find_or_create_by(
        name: "#{c.name} Fee",
        unit_price: row[14],
        product_type: "fee",
        registration_period_id: rp.id
      )
      c.products << p
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

