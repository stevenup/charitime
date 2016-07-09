# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'charitime'
set :scm, :git
set :branch, 'dev'
set :repo_url, 'git@github.com:stevenup/charitime.git'
set :user, 'root'
set :ssh_options, {
  forward_agent: true
}

# rbenv
set :rbenv_ruby, '2.3.0'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :keep_releases, 5

set :linked_files, %w{config/database.yml config/application.yml config/secrets.yml config/wechat.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do
  desc "Start the Unicorn process when it isn't already running."
  task :start do
    on roles(:app) do
      within release_path do
        execute :bundle, 'exec', "unicorn", "-Dc", 'config/unicorn.rb', "-E production"
      end
    end
  end

  desc "Initiate a rolling restart by telling Unicorn to start the new application code and kill the old process when done."
  task :restart do
    run "kill -USR2 $(cat #{app_path}/pids/unicorn.pid)"
  end

  desc "Stop the application by killing the Unicorn process"
  task :stop do
    run "kill $(cat #{app_path}/tmp/pids/unicorn.pid)"
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
