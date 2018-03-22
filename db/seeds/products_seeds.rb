Product.destroy_all

products = Product.create([
  {
    name: "2018/2019 Class Tuition-Monthly",
    unit_price: 55
  },{
    name: "2018/2019 Class Tuition-Semester",
    unit_price: 205
  },{
    name: "2018/2019 Registration",
    unit_price: 100
  },{
    name: "2018/2019 Study Hall - Monthly",
    unit_price: 28
  },{
    name: "2018/2019 Study Hall-Semester",
    unit_price: 100
  },{
    name: "Applied Science Class Fee",
    unit_price: 30
  },{
    name: "Art/Hist Class Fee",
    unit_price: 70
  },{
    name: "Biology Class Fee",
    unit_price: 50
  },{
    name: "Chemistry Class fee",
    unit_price: 75
  },{
    name: "Family Registration Discount",
    unit_price: -50
  },{
    name: "General Science class fee",
    unit_price: 50
  },{
    name: "Geography Class Fee",
    unit_price: 20
  },{
    name: "Late Registration Fee",
    unit_price: 50
  },{
    name: "Middle School Math fee",
    unit_price: 50
  },{
    name: "Physical Science Class Fee",
    unit_price: 95
  },{
    name: "PreAlgebra Class fee",
    unit_price: 95
  },{
    name: "Studio Art class fee",
    unit_price: 100
  }])

  p "Created #{Product.count} products"
