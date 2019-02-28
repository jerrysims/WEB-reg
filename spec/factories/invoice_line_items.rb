FactoryBot.define do
  factory :invoice_line_item do
    student_id { 1 }
    product_id { 1 }
    quantity { 1 }
    invoice_id { 1 }
  end

end
