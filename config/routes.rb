Kontax::Application.routes.draw do
  resources :contacts
  resource  :dashboard

  root to: 'dashboards#show'
end
