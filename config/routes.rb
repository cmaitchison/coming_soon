ComingSoon::Application.routes.draw do
  
  resources :watchers
  root :to => 'home#index'
end
