# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'w.jilin365.cn'
set :repo_url, 'git@github.com:zhaoxl/jilin365.git'
set :stages, %w(master)
# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

set :default_stage, "master"

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads', 'tmp/qrcodes', 'tmp/wechat')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# namespace :deploy do
#
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#       execute 'cd /var/www/weshop/current && kill -USR2 `cat tmp/pids/unicorn.pid`'
#       # Here we can do anything such as:
#       # within release_path do
#       #   execute :rake, 'cache:clear'
#       # end
#     end
#   end
#
# end


# namespace :deploy do
#   task :restart do
#      execute :rake,  "/var/www/weshop/current && unicorn -c config/unicorn.rb -E development -D"
#   end
#
#   task :restart do
#     execute :rake,  '/var/www/weshop/current && kill -USR2 `cat tmp/pids/unicorn.pid`'
#   end
# end

task :restart do
  on roles(:web) do
    execute "cd /srv/www/w.jilin365.cn /current && kill -USR2 `cat tmp/pids/unicorn.pid`"
  end
end
after "deploy:published", "restart"
