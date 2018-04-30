Rails.application.routes.draw do
  resources :courses
  devise_for :parents
  devise_for :admin_users, ActiveAdmin::Devise.config

  devise_scope :parent do
    authenticated :parent do
      root 'enrollments#select_student', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :students
  resources :student_shadows
  get 'shadow_spots/create'
  get '/enrollment', to: 'enrollments#new', as: :new_enrollment_path
  get '/enrollment/select_student', to: 'enrollments#select_student', as: :select_student_path
  patch '/enrollment/student-info', to: 'enrollments#student_info', as: :student_enrollment_info_path
  post '/enrollment/student-info', to: 'enrollments#new_student_info', as: :new_student_enrollment_info_path
  get '/enrollment/view_course_list', to: 'enrollments#view_course_list', as: :view_course_list_path
  get '/registrations', to: 'registrations#index', as: :register_path
  get '/registrations/choose_class', to: 'registrations#choose_class', as: :choose_class_path
  get '/registrations/drop_class', to: 'registrations#drop_class'
  get '/registrations/add_to_wait_list', to: 'registrations#add_to_wait_list'
  get '/registrations/complete_parent_info', to: 'registrations#complete_parent_info', as: :complete_parent_info
  patch '/registrations/update_parent', to: 'registrations#update_parent'
  get '/registrations/review', to: 'registrations#review'
  get '/registrations/finalize', to: 'registrations#finalize'
  patch '/registrations/update_tuition_preference', to:'registrations#update_tuition_preference'
  patch '/invoices/update_donation_amount', to: 'invoices#update_donation_amount'
  post '/invoices/update_donation_amount', to: 'invoices#update_donation_amount'
  patch '/invoices/update_program_donation', to: 'invoices#update_program_donation'
  post '/invoices/update_program_donation', to: 'invoices#update_program_donation'
  get '/invoices/generate_initial_invoice', to: 'invoices#generate_initial_invoice'
  get '/invoices/donate_now', to: 'invoices#donate_now'

  ActiveAdmin.routes(self)

  root 'students#index'
  post 'students/:id/change_lunch' => 'students#change_lunch', as: :change_lunch
end
