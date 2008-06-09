ActionController::Routing::Routes.draw do |map|
  map.root :controller => "twonks"
  map.login 'login', :controller => "sessions", :action => "new"
  map.logout 'logout', :controller => "sessions", :action => "destroy"
  map.signup 'signup', :controller => "users", :action => "new"
  map.about 'about', :controller => "pages", :action => "about"
  map.resources :twonks do |twonk|
    twonk.resources :votes
  end
  map.your_twonks 'your_twonks', :controller => "users", :action => "your_twonks"
  map.resources :users
  map.resources :sessions
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
