Kontax::Application.routes.draw do
  resources :contacts do 
    get   'scope/:scope',   to: 'contacts#index',  as: :case,   on: :collection
    match 'case/:case',     to: 'contacts#update', as: :case,   on: :member, via: [:put, :patch]
    get   'notify/:notify', to: 'contacts#show',   as: :notify, on: :member
  end 
  resource  :dashboard, only: [:show]

  root to: 'dashboards#show'
end
