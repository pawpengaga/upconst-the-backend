Rails.application.routes.draw do

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'sign_up'
  },
  controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/password/forgot', to: 'users/passwords#forgot', as: 'forgot_password'
  end

#  resources :users do
#     resources :habits, only: [:index, :show, :create, :update, :destroy]
#     resources :trackers, only: [:index, :show, :create, :update, :destroy]
#  end
resources :habits, only: [:index, :show, :create, :update, :destroy] do
  resources :trackers, only: [:index, :show, :create, :update, :destroy]
end

resources :trackers, only: [:index, :show, :create, :update, :destroy]

#post 'users/password/forgot', to: 'users/passwords#forgot', as: 'forgot_password'
#get 'users/password/forgot', to: 'users/passwords#forgot', as: 'new_forgot_password'
  # get 'trackers/index'
  # get 'trackers/show'
  # get 'trackers/create'
  # get 'trackers/update'
  # get 'trackers/destroy'
  #...........................
  # get 'habits/index'
  # get 'habits/show'
  # get 'habits/create'
  # get 'habits/update'
  # get 'habits/destroy'
end
