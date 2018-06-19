Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :houses
  resources :headers
  
  get 'prefectures/:id', to: 'prefectures#show', as: :prefecture
  get 'rent_condition/index'
  get 'rent_condition/show'
  get 'rent_station/index'
  get 'rent_station/show'
  get 'rent_area/index'
  get 'rent_area/show'
  get 'rent/index'
  get 'rent/show'
  get 'buy/index'
  get 'buy/show'
  get 'stay/index'
  get 'stay/show'
	root 'top#index'
  
  get 'top/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
