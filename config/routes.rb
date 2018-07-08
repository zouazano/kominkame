Rails.application.routes.draw do

  get 'rent_search/index'
  get 'stay_prefectures/index'
  get 'stay_prefectures/show'
  get 'buy_prefectures/index'
  get 'buy_prefectures/show'
  get 'rent_prefectures/index'
  get 'rent_prefectures/show'
  get 'rent_prefecture/index'
  get 'rent_prefecture/show'
  get 'buy_area/index'
  get 'buy_area/show'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :houses do  
    resources :inquiries, only: [:new, :create, :show, :update]
  end
  resources :headers

  get 'prefectures/:id', to: 'prefectures#show', as: :prefecture
  get 'rent_prefectures/:id', to: 'rent_prefectures#show', as: :rent_prefecture
  get 'buy_prefectures/:id', to: 'buy_prefectures#show', as: :buy_prefecture
  get 'stay_prefectures/:id', to: 'stay_prefectures#show', as: :stay_prefecture
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
