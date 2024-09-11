Rails.application.routes.draw do
  resources :tasks do
    member do
      patch :toggle_complete
    end
  end
  root 'tasks#index'
end
