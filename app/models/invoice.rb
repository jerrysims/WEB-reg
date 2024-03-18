class Invoice < ActiveRecord::Base

  belongs_to :parent
  belongs_to :registration_period
  has_many :invoice_line_items

  scope :closed, -> { where(closed: true) }

  def generate_initial_invoice(rp)
    generate_registration_fees(rp)
    generate_course_fees(rp)
    generate_administrative_fee(rp)
    update_donation_amount(rp)
  end

  def generate_administrative_fee(rp)
    InvoiceLineItem.find_or_create_by(
      product: Product.administrative_fee(rp), 
      parent: parent, 
      quantity: 1, 
      registration_period_id: rp.id,
      invoice: self)
  end

  def generate_registration_fees(rp)
    parent.registered_students(rp).each do |student|
      InvoiceLineItem.find_or_create_by(
        product: student.reg_fee(rp), 
        parent: parent, 
        quantity: 1, 
        student_id: student.id, 
        registration_period_id: rp.id,
        invoice: self)
    end
    if parent.registered_students(rp).count > 1
      InvoiceLineItem.find_or_create_by(
        product: Product.sibling_discount(rp), 
        parent: parent, 
        quantity: 1, 
        registration_period_id: rp.id,
        invoice: self)
    end
  end

  def generate_course_fees(rp)
    parent.registered_students(rp).each do |student|
      student.rp_courses(rp).each do |course|
        if course.fee_product
          InvoiceLineItem.create(
            product: course.fee_product, 
            parent: parent, 
            quantity: 1, 
            student_id: student.id, 
            registration_period_id: rp.id,
            invoice: self)
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

  def update_donation_amount(rp)
    if donation_item = InvoiceLineItem.find_by(parent: parent, registration_period_id: rp.id, invoice: nil)
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

  def self.administrative_fee(rp)
    Product.where(name: "Administrative Fee", registration_period_id: rp.id).first.unit_price
  end

  def self.get_donation(parent)
    donation_product = Product.where(name: "Scholarship Donation").first
    parent.invoice_line_items.find_by(product: donation_product)
  end

  def self.get_program_donation(parent, rp)
    program_donation_product = Product.where(name: "Program Donation", registration_period_id: rp).first
    parent.invoice_line_items.find_by(product: program_donation_product)
  end

  def self.initial_invoice_total(parent, rp)
    @invoice_total = 0
    parent.students.each do |s|
      @invoice_total +=  registration_fee if s.sections.count > 0
    end
    @invoice_total += Invoice.discount(rp) if parent.enrolled_students_count(@rp) > 0
    @invoice_total += administrative_fee if @invoice_total > 0

    @invoice_total
  end

  def self.registration_fee(rp)
    Product.where(name: "Registration Fee", registration_period_id: rp).first.unit_price
  end

  def self.discount(rp)
    Product.find_by(name: "Sibling Discount", registration_period_id: rp.id).unit_price
  end
end
