Rails.application.routes.draw do
  # get 'habits/index'
  # get 'habits/show'
  # get 'habits/create'
  # get 'habits/update'
  # get 'habits/destroy'

  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'sign_up'
  },
  controllers:{
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  resources :habits, only: [:index, :show, :create, :update, :destroy]

end
