ActionController::Routing::Routes.draw do |map|
  map.resources :twonks
  map.resources :users
  map.resource :session
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
