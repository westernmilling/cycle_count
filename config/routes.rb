Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               sessions: 'users/sessions'
             },
             skip: [:registrations]

  root 'site/home#index'
end
