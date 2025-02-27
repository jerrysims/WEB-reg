namespace :products do
  task :seed => :environment do
    puts "Starting product seeding task..."

    rp = RegistrationPeriod.find_or_create_by(
      name: "2025-26 Academic Year",
      open_date: Date.new(2025, 2, 18),
      close_date: Date.new(2025, 8, 1),
      rp_type: "academic"
    )
    puts "Registration period created or found: #{rp.inspect}"

    products = [
      { name: "Middle School Tuition - Semester", unit_price: 297.5, product_type: "tuition" },
      { name: "Registration Fee - one class", unit_price: 55, product_type: "registration" },
      { name: "Registration Fee - two classes", unit_price: 85, product_type: "registration" },
      { name: "Registration Fee - three classes", unit_price: 110, product_type: "registration" },
      { name: "Administrative Fee", unit_price: 110, product_type: "registration" },
      { name: "Middle School Tuition - Monthly", unit_price: 80, product_type: "tuition" },
      { name: "Middle School Tuition Twice Weekly - Semester", unit_price: 462.5, product_type: "tuition" },
      { name: "Middle School Tuition Twice Weekly - Monthly", unit_price: 125, product_type: "tuition" },
      { name: "High School Tuition - Semester", unit_price: 315, product_type: "tuition" },
      { name: "High School Tuition - Monthly", unit_price: 85, product_type: "tuition" },
      { name: "High School Tuition Twice Weekly - Semester", unit_price: 485, product_type: "tuition" },
      { name: "High School Tuition Twice Weekly - Monthly", unit_price: 130, product_type: "tuition" },
      { name: "Study Hall Tuition - Semester", unit_price: 147.5, product_type: "tuition" },
      { name: "Study Hall Tuition - Monthly", unit_price: 40, product_type: "tuition" },
      { name: "Sibling Discount", unit_price: -50, product_type: "registration" },
      { name: "Extracurricular Tuition - Semester", unit_price: 192.5, product_type: "extracurricular" },
      { name: "Extracurricular Tuition - Monthly", unit_price: 55, product_type: "extracurricular" },
      { name: "Band, Choir, Intermediate Art, Journalism Tuition - Semester", unit_price: 315, product_type: "extracurricular" },
      { name: "Band, Choir, Intermediate Art, Journalism Tuition - Monthly", unit_price: 85, product_type: "extracurricular" }
    ]

    products.each do |product|
      created_product = Product.find_or_create_by(
        name: product[:name],
        unit_price: product[:unit_price],
        product_type: product[:product_type],
        registration_period_id: rp.id
      )
      puts "Product created or found: #{created_product.inspect}"
    end

    puts "Product seeding task completed."
  end
end


