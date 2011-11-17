Tiara::Application.routes.draw do  resources :records
  resources :records
  resources :courts

  put 'reindex' => 'sphinx#index', as: 'reindex'

  scope '/export' do
    root :to => 'export#index', as: 'exports'
    match ':resource' => 'export#export', as: 'export'
  end

  root :to => 'pages#home'
end
