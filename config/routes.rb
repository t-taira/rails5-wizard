Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :products do
    resources :build, controller: 'products/build'
  end
  root to: 'products#new'
end
