ActiveAdmin.register InvoiceLineItem do
  menu parent: "Admin"

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :parent_id, :invoice_id, :product_id, :quantity
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    column :student do |c|
      c.student_id.nil? ? nil : Student.find(c.student_id).full_name
    end
    column :product
    column :quantity
    column :invoice
    column :parent
    column :created_at

    actions
  end

  form do |f|
    f.inputs do
      f.input :invoice, as: :select, collection: options_from_collection_for_select(Invoice.all, :id, lambda { |i| "#{i.parent.full_name}"})
      f.input :parent
      f.input :product
      f.input :quantity
      actions
    end
  end

  csv do
    column "id" do |i|
      i.id
    end
    column "Student ID" do |i|
      student = Student.find_by(id: i.student_id)
      student.present? ? student.id : ""
    end
    column "Student Name" do |i|
      student = Student.find_by(id: i.student_id)
      student.present? ? student.full_name : ""
    end
    column "Parent ID" do |i|
      i.parent_id
    end
    column "Parent Name" do |i|
      i.parent.full_name
    end
    column "Street Address 1" do |i|
      i.parent.street_address_1
    end
    column "Street Address 2" do |i|
      i.parent.street_address_2
    end
    column "City" do |i|
      i.parent.city
    end
    column "Zip Code" do |i|
      i.parent.zip_code
    end
    column "State" do |i|
      i.parent.state
    end
    column "Email" do |i|
      i.parent.email
    end
    column "Product ID" do |i|
      product = Product.find_by(id: i.product_id)
      product.id
    end
    column "Product Name" do |i|
      product = Product.find_by(id: i.product_id)
      product.nil? ? "" : product.name
    end
    column "Quantity" do |i|
      i.quantity
    end
    column "Unit Price" do |i|
      product = Product.find_by(id: i.product_id)
      product.nil? ? "" : '%.2f' % product.unit_price
    end
  end
end
