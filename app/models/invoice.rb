class Invoice < ActiveRecord::Base

  belongs_to :parent
  has_many :invoice_line_items

  def generate_initial_invoice
    generate_registration_fees
    generate_course_fees
    binding.pry
    update_donation_amount
    binding.pry
  end

  def generate_registration_fees
    parent.registered_students.each do |student|
      InvoiceLineItem.create(product: Product::REGISTRATION_FEE, parent: parent, quantity: 1, student_id: student.id, invoice: self)
    end
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

  def update_donation_amount
    if donation_item = InvoiceLineItem.find_by(parent: parent)
      donation_item.update_attributes(invoice: self)
    end
  end

  def self.get_tuition_totals(parent)
    course_count = 0
    parent.students.each{ |s| course_count += s.course_count }
    study_hall_count = 0
    parent.students.each{ |s| study_hall_count += s.study_hall_count}
    annual_unit = Product.where(name: "2018/2019 Class Tuition-Annual").first.unit_price
    monthly_unit = Product.where(name: "2018/2019 Class Tuition-Monthly").first.unit_price
    semester_unit = Product.where(name: "2018/2019 Class Tuition-Semester").first.unit_price
    study_hall_monthly = Product.where(name: "2018/2019 Study Hall - Monthly").first.unit_price
    study_hall_semester = Product.where(name: "2018/2019 Study Hall-Semester").first.unit_price
    study_hall_annual = study_hall_semester * 2

    annual_tuition = (course_count * annual_unit) + (study_hall_count * study_hall_annual)
    semester_tuition = (course_count * semester_unit) + (study_hall_count * study_hall_semester)
    monthly_tuition = (course_count * monthly_unit) + (study_hall_count * study_hall_monthly)

    [ annual_tuition, semester_tuition, monthly_tuition ]
  end

  def self.get_donation(parent)
    donation_product = Product.where(name: "Scholarship Donation").first
    invoice_line_item = parent.invoice_line_items.where(product: donation_product)
    invoice_line_item.empty? ? nil : invoice_line_item.first
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
