Rails.application.routes.draw do
  resources :talks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "talks#index"

end
