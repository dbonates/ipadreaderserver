require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/mysql"
# load "config/recipes/nodejs"
# load "config/recipes/rbenv"
# load "config/recipes/check"

ssh_options[:port] = 63

server "bonates.com", :web, :app, :db, primary: true

set :user, "dbonates"
set :application, "ipadreaderserver"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, true

set :scm, "git"
# set :local_repository, "."
set :repository, "https://github.com/dbonates/ipadreaderserver.git"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
