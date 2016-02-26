Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions'
             },
             skip: [:registrations]

  resources :cycle_counts do
    resources :pallets
  end

  resources :locations

  namespace :admin do
    resources :users
  end

  root 'site/home#index'
end
