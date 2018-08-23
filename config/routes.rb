# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  mount Ebisu::Engine => '/'

  devise_for :admins
  get 'rent_search/index'
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
    resources :inquiries, only: %i[new create show update]
  end

  resources :headers

  resources :rent_houses, only: [:show]
  resources :buy_houses, only: [:show]
  resources :stay_houses, only: [:show]


  get 'prefectures/:id', to: 'prefectures#show', as: :prefecture
  resources :buy_prefectures, only: [:index, :show]
  resources :rent_prefectures, only: [:index, :show]
  resources :stay_prefectures, only: [:index, :show]

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

  root to: "top#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
