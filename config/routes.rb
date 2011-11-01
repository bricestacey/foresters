Tiara::Application.routes.draw do  resources :records
  resources :records
  resources :courts

  root :to => 'pages#home'
end
