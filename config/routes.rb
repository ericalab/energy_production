Rails.application.routes.draw do
  root 'static_pages#home'

  resources :users do
    collection { post :import }
  end

  resources :datasets do
    collection { post :import }
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
