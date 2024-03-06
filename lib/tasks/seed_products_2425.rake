# lib/tasks/invoices.rake
namespace :products_2024 do
  task :seed => :environment do
    rp = RegistrationPeriod.find_by(name: "2024-25 Academic Year", rp_type: "academic")

    Product.create(registration_period_id: rp.id, unit_price: 1.0, product_type: :donation , name: "Scholarship Donation")
    Product.create(registration_period_id: rp.id, unit_price: 55.0, product_type: :registration, name: "Registration Fee - one class")
    Product.create(registration_period_id: rp.id, unit_price: 85.0, product_type: :registration, name: "Registration Fee - two classes")
    Product.create(registration_period_id: rp.id, unit_price: 110.0, product_type: :registration, name: "Registration Fee - three classes")
    Product.create(registration_period_id: rp.id, unit_price: 110.0, product_type: :registration, name: "Administrative Fee")
    Product.create(registration_period_id: rp.id, unit_price: 270.0, product_type: :tuition, name: "Middle School Tuition - Semester")
    Product.create(registration_period_id: rp.id, unit_price: 72.0, product_type: :tuition, name: "Middle School Tuition - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 420.0, product_type: :tuition, name: "Middle School Tuition Twice Weekly - Semester")
    Product.create(registration_period_id: rp.id, unit_price: 112.0, product_type: :tuition, name: "Middle School Tuition Twice Weekly - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 287.5, product_type: :tuition, name: "High School Tuition - Semester")
    Product.create(registration_period_id: rp.id, unit_price: 76.0, product_type: :tuition, name: "High School Tuition - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 440.0, product_type: :tuition, name: "High School Tuition Twice Weekly - Semester")
    Product.create(registration_period_id: rp.id, unit_price: 117.0, product_type: :tuition, name: "High School Tuition Twice Weekly - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 135.0, product_type: :tuition, name: "Study Hall Tuition - Semester")
    Product.create(registration_period_id: rp.id, unit_price: 36.0, product_type: :tuition, name: "Study Hall Tuition - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: -50.0, product_type: :registration, name: "Sibling Discount")
    Product.create(registration_period_id: rp.id, unit_price: 175.0, product_type: :extracurricular, name: "Extracurricular Tuition - Semester")
    Product.create(registration_period_id: rp.id, unit_price: 47.0, product_type: :extracurricular, name: "Extracurricular Tuition - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 280.0, product_type: :extracurricular, name: "Band, Choir, Theater, Yearbook/Journalism Tuition - Semester")
    Product.create(registration_period_id: rp.id, unit_price: 74.0, product_type: :extracurricular, name: "Band, Choir, Theater, Yearbook/Journalism Tuition - Monthly")


    puts "Created #{Product.where(registration_period_id: rp.id).count} products"
  end
end