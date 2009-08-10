  begin
    $TESTING = true # workaround a conflict between DataMapper and Vlad
    require "vlad"
    Vlad.load(:app => :thin, :scm => "git")
  rescue LoadError
    # do nothing
  end
  
namespace :vlad do
  desc 'Runs vlad:update, vlad:symlink'
  task :deploy => ['vlad:update', 'vlad:symlink']

  desc 'Symlinks your custom directories'
  remote_task :symlink, :roles => :app do
    run "ln -s #{shared_path}/database.yml #{current_release}/config/database.yml"
    run "ln -s #{shared_path}/mail_init.rb #{current_release}/config/mail_init.rb"
    run "ln -s #{shared_path}/initial_data.txt #{current_release}/config/initial_data.txt"
  end
end

