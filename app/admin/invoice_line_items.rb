ActiveAdmin.register InvoiceLineItem do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :parent_id, :student_id, :invoice_id, :product_id, :quantity
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

form do |f|
  f.inputs do
    f.input :invoice, as: :select, collection: options_from_collection_for_select(Invoice.all, :id, lambda { |i| "#{i.parent.full_name}"})
    f.input :parent
    f.input :student
    f.input :product
    f.input :quantity
    actions
  end
end

end
