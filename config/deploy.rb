set :application, 'slnky'
set :repo_url, 'git@github.com:slnky/slnky-server'

# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "#{ENV['DEPLOY_DIR']}/#{fetch(:application)}#{fetch(:stage) == 'staging' ? '-stg' : ''}"
# set :scm, :git

# set :log_level, :debug
# set :pty, true

set :linked_files, %w{.env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

set :migration_role, 'app'
set :conditionally_migrate, true

set :rvm_ruby_version, File.read('.ruby-version').chomp      # Defaults to: 'default'

set :nginx_server_name, 'slnky.ulive.sh slnky-pub.ulive.sh'
set :unicorn_logrotate_enabled, true
# ignore this if you do not need SSL
set :nginx_use_ssl, true
set :nginx_upload_local_cert, false # already installed on server
# TODO: get ulive.sh ssl cert
set :nginx_ssl_cert, 'wildcard.ulive.sh.combined.crt'
set :nginx_ssl_cert_key, 'wildcard.ulive.sh.key'

namespace :deploy do
  desc 'push env file to server'
  task :dotenv do
    on roles(:app) do
      upload! File.expand_path("./deploy.env"), "#{shared_path}/.env"
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
