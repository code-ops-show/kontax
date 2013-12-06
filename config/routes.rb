Kontax::Application.routes.draw do
  resources :contacts do 
    get 'case/:case', to: 'contacts#index', as: :case, on: :collection
    match 'case/:case', to: 'contacts#update', as: :case, on: :member, via: [:put, :patch]
  end 
  resource  :dashboard, only: [:show]

  root to: 'dashboards#show'
end
