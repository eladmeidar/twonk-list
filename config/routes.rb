ActionController::Routing::Routes.draw do |map|
  map.root :controller => "twonks"
  map.resources :twonks
  map.resources :users
  map.resource :session
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
