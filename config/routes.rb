ActionController::Routing::Routes.draw do |map|
  map.root :controller => "twonks"
  map.resources :twonks do |twonk|
    twonk.resources :votes
  end
  map.resources :users
  map.resource :session
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
