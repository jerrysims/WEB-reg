require 'csv'

# lib/tasks/invoices.rake
namespace :courses_2026 do
  task :seed => :environment do
    rp = RegistrationPeriod.find_by(name: "2026-27 Academic Year")

    if rp.nil?
      rp = RegistrationPeriod.create(
        name: "2026-27 Academic Year", 
        open_date: "2026-02-24", 
        close_date: "2026-02-28", 
        rp_type: "academic"
      )
    end

    CSV.foreach("public/2026_registration_data.csv", headers: true) do |row|
      # ensure course saves or blow up so we don't end up with nil references
      c = Course.find_or_initialize_by(
        name: row["Course Name"],
        registration_period_id: rp.id
      )
      c.assign_attributes(
        subject_area: row["Subject Area"],
        division: row["MS/HS"],
        description: row["Course Description"],
        grades: row["Grades"],
        suggested_grade: row["Grades"],
        tuition: row["Tuition"]
      )
      c.save!

      s = Section.create!(
        day: row["Day"],
        start_time: row["Time"].split('-')[0],
        end_time: row["Time"].split('-')[1],
        class_minimum: row["Class Min"],
        class_maximum: row["Class Max"],
        course: c
      )
      p = Product.find_or_create_by(
        name: "#{c.name} Fee",
        unit_price: row["Supply Fee"],
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
