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
end
