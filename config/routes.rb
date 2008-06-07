ActionController::Routing::Routes.draw do |map|
  map.root :controller => "twonks"
  map.login 'login', :controller => "session", :action => "new"
  map.logout 'logout', :controller => "session", :action => "destroy"
  map.signup 'signup', :controller => "users", :action => "new"
  map.resources :twonks do |twonk|
    twonk.resources :votes
  end
  map.resources :users
  map.resource :session
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
