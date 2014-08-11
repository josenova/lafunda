# config valid only for Capistrano 3.1
lock '3.2.1'
require 'delayed/recipes'

set :application, 'lafunda'
set :repo_url, 'git@bitbucket.org:kinbar/lafunda.git'

# Default value for :scm is :git
set :scm, :git

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/apps/lafunda'

set :user, "deploy"
set :group, "deployers"
set :use_sudo, false

set :bundle_flags,    ""
# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5


set :rails_env, "production"
set :deploy_via, :copy
set :copy_strategy, :export


namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      # execute :rake, 'cache:clear'
      # end
    end
  end

  desc "Copy the database.yml file into the latest release"
  task :copy_in_database_yml do
    #run "cp #{shared_path}/config/database.yml #{latest_release}/config/"
    run "#{try_sudo} ln -s #{deploy_to}/shared/config/database.yml #{current_path}/config/database.yml"
  end

  desc "Precompile assets after deploy"
  task :precompile_assets do
    run <<-CMD
      cd #{current_path} &&
      #{try_sudo} bundle exec rake assets:precompile RAILS_ENV=#{rails_env}
    CMD
  end

  desc "Remove Symbolic Link from Shared folder"
  task :removesharedsymlink do
    on roles(:web) do
      execute "rm #{deploy_to}/shared/public/assets/assets"
    end
  end

  desc "Check that we can access everything"
  task :check_write_permissions do
    on roles(:all) do |host|
      if test("[ -w #{fetch(:deploy_to)} ]")
        info "#{fetch(:deploy_to)} is writable on #{host}"
      else
        error "#{fetch(:deploy_to)} is not writable on #{host}"
      end
    end
  end


end


after "deploy", "deploy:restart"

set :delayed_job_command, "bin/delayed_job"
after "deploy:start", "delayed_job:start"
after "deploy:stop", "delayed_job:stop"
after "deploy:restart", "delayed_job:stop","delayed_job:start"

