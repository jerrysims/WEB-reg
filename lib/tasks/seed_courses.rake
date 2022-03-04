# lib/tasks/invoices.rake
namespace :courses do
  task :seed => :environment do
    CSV.foreach("public/2022_registration_data.csv") do |row|
      c = Course.find_or_create_by(
        name: row[0],
        subject_area: row[1],
        teacher: row[3],
        description: row[4],
        grades: row[5],
        suggested_grade: row[6]
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
