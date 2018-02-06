Rails.application.routes.draw do
  devise_for :parents

  devise_scope :parent do
    authenticated :parent do
      root 'students#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :students
  resources :student_shadows
  get 'shadow_spots/create'
  get '/enrollment', to: 'enrollments#new', as: :new_enrollment_path

  ActiveAdmin.routes(self)

  root 'students#index'
  post 'students/:id/change_lunch' => 'students#change_lunch', as: :change_lunch
end
