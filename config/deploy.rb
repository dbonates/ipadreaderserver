require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/mysql"
# load "config/recipes/nodejs"
# load "config/recipes/rbenv"
# load "config/recipes/check"

ssh_options[:port] = 63
ssh_options[:forward_agent] = true

server "bonates.com", :web, :app, :db, primary: true

set :user, "dbonates"
set :application, "ipadreaderserver"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, true

set :scm, "git"
set :repository, "git@github.com:dbonates/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases  

namespace :deploy do
  
  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/#{branch}`
      puts "WARNING: HEAD is not the same as origin/#{branch}"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
  
end
