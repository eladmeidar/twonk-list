ActionController::Routing::Routes.draw do |map|
  map.root :controller => "twonks"
  map.login 'login', :controller => "sessions", :action => "new"
  map.logout 'logout', :controller => "sessions", :action => "destroy"
  map.signup 'signup', :controller => "users", :action => "new"
  map.resources :twonks do |twonk|
    twonk.resources :votes
  end
  map.resources :users
  map.resources :sessions
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
