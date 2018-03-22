class Invoice < ActiveRecord::Base
  has_many :invoice_line_items
end
