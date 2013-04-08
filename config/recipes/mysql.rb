# set_default(:postgresql_host, "localhost")
# set_default(:postgresql_user) { application }
# set_default(:postgresql_password) { Capistrano::CLI.password_prompt "PostgreSQL Password: " }
# set_default(:postgresql_database) { "#{application}_production" } 
                                                                    
set_default(:db_user) { application }
set_default(:db_pass) { Capistrano::CLI.password_prompt("mySQL database user password: ") }
set_default(:root_password) { Capistrano::CLI.password_prompt("MySQL root password: ") }
set_default(:db_name) { "#{application}_production" }
set_default(:mysql_host, "localhost")

namespace :mysql do
  desc "Install the latest stable release of mySQL. (*** SKIPPING THIS STEP!)"
  task :install, roles: :db, only: {primary: true} do
    #run "#{sudo} add-apt-repository ppa:pitti/postgresql"
    #run "#{sudo} apt-get -y update"
    #run "#{sudo} apt-get -y install postgresql libpq-dev"
  end
  after "deploy:install", "postgresql:install"

  desc "Create a database for this application."
  task :create_database, roles: :db, only: {primary: true} do
    #run %Q{#{sudo} -u postgres psql -c "create user #{postgresql_user} with password '#{postgresql_password}';"}
    #run %Q{#{sudo} -u postgres psql -c "create database #{postgresql_database} owner #{postgresql_user};"}
    run "mysql --user=root --password=#{root_password} -e \"CREATE DATABASE IF NOT EXISTS #{db_name}\""
    run "mysql --user=root --password=#{root_password} -e \"GRANT ALL PRIVILEGES ON #{db_name}.* TO '#{db_user}'@'localhost' IDENTIFIED BY '#{db_pass}' WITH GRANT OPTION\""
  end
  after "deploy:setup", "mysql:create_database"

  desc "Generate the database.yml configuration file."
  task :setup, roles: :app do
    #run "mkdir -p #{shared_path}/config"
    template "mysql.yml.erb", "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "mysql:setup"

  desc "Symlink the database.yml file into latest release"
  task :symlink, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "mysql:symlink"
end
