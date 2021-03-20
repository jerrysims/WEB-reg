# lib/tasks/invoices.rake
namespace :courses do
  task :seed => :environment do
    CSV.foreach("public/2021_registration_data.csv") do |row|
      c = Course.find_or_create_by name: row[0], subject_area: row[1], teacher: row[2],
                                   description: row[3], grades: row[4], suggested_grade: row[5]
      s = Section.create day: row[6], start_time: row[7], end_time: row[8], class_minimum: row[10],
                         class_maximum: row[11], course_id: c.id
      p = Product.find_or_create_by name: "#{c.name} Fee", unit_price: row[9], product_type: "fee"
      c.products << p
    end
  end
end
