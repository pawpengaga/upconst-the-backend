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

#  resources :users do
#     resources :habits, only: [:index, :show, :create, :update, :destroy]
#     resources :trackers, only: [:index, :show, :create, :update, :destroy]
#  end

  resources :habits, only: [:index, :show, :create, :update, :destroy]
  resources :trackers, only: [:index, :show, :create, :update, :destroy]

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
