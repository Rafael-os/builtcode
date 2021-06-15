Rails.application.routes.draw do
  resources :doctors, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :patients, only: [:index, :new, :create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
