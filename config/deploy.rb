set :application, "twonklist"
set :repository,  "git://github.com/Radar/twonk-list.git"

set :deploy_to, "/var/www/#{application}"

set :scm, :git

role :app, "twonklist.com"
role :web, "twonklist.com"
role :db,  "twonklist.com", :primary => true

set :user, 'root'

namespace :deploy do
  task :after_update_code, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/system/database.yml #{release_path}/config/database.yml"
  end
  
  task :after_symlink, :roles => [ :app, :web ] do
    sudo "apache2ctl restart"
  end
end
