ActiveAdmin.register RegistrationPeriod do
  menu parent: "Admin"

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
permit_params :name, :open_date, :close_date, :rp_type, :semester, :status
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
      f.input :name
      f.input :open_date
      f.input :close_date
      f.input :rp_type, as: :select, collection: RegistrationPeriod::RP_TYPES
      f.input :semester
      f.input :status, as: :select, collection: RegistrationPeriod::RP_STATUSES
    end
    f.actions
  end

end
