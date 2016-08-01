Rails.application.routes.draw do
  root to: 'material_sources#index'
  resources :material_sources
end
