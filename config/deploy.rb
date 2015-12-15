# config valid only for current version of Capistrano
# require 'capistrano/ext/multistage'
lock '3.4.0'

# set :application, 'test_demo'
# set :repo_url, 'https://github.com/zhoukailove/test_demo.git'
# set :scm, :git
# # set :repository, "git@account.beanstalkapp.com:/repository.git"
# set :scm_passphrass, "314lovemanli"
# set :user, "root@lanrenol.com"

# set :application, "test_demo"
#
# set :scm, :git
# set :repository, "https://github.com/zhoukailove/test_demo.git"
# set :scm_passphrase, "314lovemanli"
# set :user, "root@lanrenol.com"
# set :stages, ["staging", "production"]
# set :default_stage, "staging"

# config valid only for Capistrano 3.1
# lock '3.2.1'

set :application, 'test_demo'
set :repo_url, 'https://github.com/zhoukailove/test_demo.git'

set :deploy_to, '/home/zhouzhen/test_demo'

set :scm, :git


# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}


set :keep_releases, 5

after 'deploy:publishing', 'deploy:restart'

namespace :deploy do



  desc 'Restart application'
  task :restart do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          # execute :rake, "up_assets"
        end
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do

    end
  end

  after :finishing, 'deploy:cleanup'
  before :finishing, 'deploy:restart'

  after 'deploy:rollback', 'deploy:restart'
end


