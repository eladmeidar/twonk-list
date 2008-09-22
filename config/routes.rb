ActionController::Routing::Routes.draw do |map|
  map.root :controller => "twonks"
  map.about 'about', :controller => "pages", :action => "about"
  map.resources :twonks do |twonk|
    twonk.resources :votes
  end
  map.namespace :admin do |admin|
    admin.resources :sessions
    admin.resources :twonks, :member => { :accept => :put }
  end
  map.connect 'admin', :controller => 'admin/twonks'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
