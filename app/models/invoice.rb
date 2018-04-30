class Invoice < ActiveRecord::Base

  belongs_to :parent
  has_many :invoice_line_items

  def generate_initial_invoice
    generate_registration_fees
    generate_course_fees
    update_donation_amount
  end

  def generate_registration_fees
    parent.registered_students.each do |student|
      InvoiceLineItem.create(product: Product::REGISTRATION_FEE, parent: parent, quantity: 1, student_id: student.id, invoice: self)
    end
    InvoiceLineItem.create(product: Product::FAMILY_DISCOUNT, parent: parent, quantity: 1, invoice: self) if parent.registered_students.count > 1
  end

  def generate_course_fees
    parent.registered_students.each do |student|
      student.courses.each do |course|
        if course.fee_product
          InvoiceLineItem.create(product: course.fee_product, parent: parent, quantity: 1, student_id: student.id, invoice: self)
        end
      end
    end
  end

  def generate_tuition_fees
    parent.registered_students.each do |student|
      student.courses.each do |course|
        if course.tuition_product
          InvoiceLineItem.create(product: course.tuition_product, parent: parent, quantity: 1, student_id: student.id, invoice: self)
        end
      end
    end
  end

  def total_due
    total = 0
    invoice_line_items.each do |item|
      unless item.product.nil?
        total += (item.quantity * item.product.unit_price)
      end
    end
    total
  end

  def update_donation_amount
    if donation_item = InvoiceLineItem.find_by(parent: parent, invoice: nil)
      donation_item.update_attributes(invoice: self)
    end
  end

  def write_to_csv
    csv_data = ""
    invoice_line_items.each do |item|
      csv_data = CSV.generate(csv_data) { |csv| csv << item.to_invoice_array }
    end
    csv_data
  end

  def self.get_tuition_totals(parent)
    course_count = 0
    parent.registered_students.each{ |s| course_count += s.course_count }
    study_hall_count = 0
    parent.students.each{ |s| study_hall_count += s.study_hall_count}
    annual_unit = Product::TUITION[:annual].unit_price
    monthly_unit = Product::TUITION[:monthly].unit_price
    semester_unit = Product::TUITION[:semester].unit_price
    study_hall_monthly = Product::STUDY_HALL[:monthly].unit_price
    study_hall_semester = Product::STUDY_HALL[:semester].unit_price
    study_hall_annual = study_hall_semester * 2

    annual_tuition = (course_count * annual_unit) + (study_hall_count * study_hall_annual)
    semester_tuition = (course_count * semester_unit) + (study_hall_count * study_hall_semester)
    monthly_tuition = (course_count * monthly_unit) + (study_hall_count * study_hall_monthly)

    [ annual_tuition, semester_tuition, monthly_tuition ]
  end

  def self.get_donation(parent)
    donation_product = Product.where(name: "Scholarship Donation").first
    parent.invoice_line_items.find_by(product: donation_product)
  end

  def self.get_program_donation(parent)
    program_donation_product = Product.where(name: "Program Donation").first
    parent.invoice_line_items.find_by(product: program_donation_product)
  end

  def self.initial_invoice_total(parent)
    @invoice_total = 0
    parent.students.each do |s|
      @invoice_total +=  registration_fee if s.courses.count > 0
      s.courses.each { |c| @invoice_total += c.fee }
    end
    @invoice_total
  end

  def self.registration_fee
    Product.where(name: "2018/2019 Registration").first.unit_price
  end

  def self.discount
    Product.where(name: "Family Registration Discount").first.unit_price
  end
end
