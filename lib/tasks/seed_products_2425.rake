# lib/tasks/invoices.rake
namespace :products_2024 do
  task :seed => :environment do
    rp = RegistrationPeriod.find_by(name: "2024-25 Academic Year", rp_type: "academic")

    Product.create(registration_period_id: rp.id, unit_price: 1.0, product_type: :donation , name: "Scholarship Donation")
    Product.create(registration_period_id: rp.id, unit_price: 55.0, product_type: :registration, name: "Registration Fee - one class")
    Product.create(registration_period_id: rp.id, unit_price: 85.0, product_type: :registration, name: "Registration Fee - two classes")
    Product.create(registration_period_id: rp.id, unit_price: 110.0, product_type: :registration, name: "Registration Fee - three classes")
    Product.create(registration_period_id: rp.id, unit_price: 110.0, product_type: :registration, name: "Administrative Fee")
    Product.create(registration_period_id: rp.id, unit_price: 540.0, product_type: :tuition, name: "Middle School Tuition - Annual")
    Product.create(registration_period_id: rp.id, unit_price: 72.0, product_type: :tuition, name: "Middle School Tuition - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 840.0, product_type: :tuition, name: "Middle School Tuition Twice Weekly - Annual")
    Product.create(registration_period_id: rp.id, unit_price: 112.0, product_type: :tuition, name: "Middle School Tuition Twice Weekly - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 575.0, product_type: :tuition, name: "High School Tuition - Annual")
    Product.create(registration_period_id: rp.id, unit_price: 76.0, product_type: :tuition, name: "High School Tuition - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 880.0, product_type: :tuition, name: "High School Tuition Twice Weekly - Annual")
    Product.create(registration_period_id: rp.id, unit_price: 117.0, product_type: :tuition, name: "High School Tuition Twice Weekly - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 270.0, product_type: :tuition, name: "Study Hall Tuition - Annual")
    Product.create(registration_period_id: rp.id, unit_price: 36.0, product_type: :tuition, name: "Study Hall Tuition - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: -50.0, product_type: :registration, name: "Sibling Discount")
    Product.create(registration_period_id: rp.id, unit_price: 350.0, product_type: :extracurricular, name: "Extracurricular Tuition - Annual")
    Product.create(registration_period_id: rp.id, unit_price: 47.0, product_type: :extracurricular, name: "Extracurricular Tuition - Monthly")
    Product.create(registration_period_id: rp.id, unit_price: 560.0, product_type: :extracurricular, name: "Band, Choir, Theater, Yearbook/Journalism Tuition - Annual")
    Product.create(registration_period_id: rp.id, unit_price: 74.0, product_type: :extracurricular, name: "Band, Choir, Theater, Yearbook/Journalism Tuition - Monthly")


    puts "Created #{Product.where(registration_period_id: rp.id).count} products"
  end
end