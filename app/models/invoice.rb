class Invoice < ActiveRecord::Base

  belongs_to :parent
  has_many :invoice_line_items

  scope :closed, -> { where(closed: true) }

  def generate_initial_invoice
    generate_registration_fees
    generate_course_fees
    generate_administrative_fee
    update_donation_amount
  end

  def generate_administrative_fee
    InvoiceLineItem.create(product: Product::ADMINISTRATIVE_FEE, parent: parent, quantity: 1, invoice: self)
  end

  def generate_registration_fees
    parent.registered_students.each do |student|
      InvoiceLineItem.create(product: Product::REGISTRATION_FEE, parent: parent, quantity: 1, student_id: student.id, invoice: self)
    end
    if parent.registered_students.count > 1
      InvoiceLineItem.create(product: Product::SIBLING_DISCOUNT, parent: parent, quantity: parent.registered_students.count - 1, invoice: self)
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

  def self.administrative_fee
    Product.where(name: "Administrative Fee").first.unit_price
  end

  def self.tuition_totals(parent)
    # standard_course_count = 0
    # parent.registered_students.each{ |s| standard_course_count += s.standard_course_count }
    # study_hall_count = 0
    # parent.students.each{ |s| study_hall_count += s.study_hall_count}
    # math_course_count = 0
    # parent.students.each{ |s| math_course_count += s.math_course_count }
    # fl_course_count = 0
    # parent.students.each{ |s| fl_course_count += s.fl_course_count }
    # monthly_unit = Product::CLASS_TUITION[:monthly].unit_price
    # semester_unit = Product::CLASS_TUITION[:semester].unit_price
    # study_hall_monthly = Product::STUDY_HALL_TUITION[:monthly].unit_price
    # study_hall_semester = Product::STUDY_HALL_TUITION[:semester].unit_price
    # math_semester = Product::MATH_CLASS_TUITION[:semester].unit_price
    # math_monthly = Product::MATH_CLASS_TUITION[:monthly].unit_price
    # fl_semester = Product::HIGH_SCHOOL_LANGUAGE_TUITION[:semester].unit_price
    # fl_monthly = Product::HIGH_SCHOOL_LANGUAGE_TUITION[:monthly].unit_price
    #
    # semester_tuition = (standard_course_count * semester_unit) + (study_hall_count * study_hall_semester) + (math_course_count * math_semester) + (fl_course_count * fl_semester)
    # monthly_tuition = (standard_course_count * monthly_unit) + (study_hall_count * study_hall_monthly) + (math_course_count * math_monthly) + (fl_course_count * fl_monthly)
    #
    # [ semester_tuition, monthly_tuition ]
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
      @invoice_total +=  registration_fee if s.sections.count > 0
    end
    @invoice_total += Invoice.discount if parent.enrolled_students_count > 0
    @invoice_total += administrative_fee if @invoice_total > 0

    @invoice_total
  end

  def self.registration_fee
    Product.where(name: "Registration Fee").first.unit_price
  end

  def self.discount
    Product.find_by(name: "Sibling Discount").unit_price
  end
end
