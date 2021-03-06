lock '3.4.0'

set :application, 'hound'
set :repo_url, 'git@github.com:bitjourney/hound.git'
set :user, 'journey'
set :branch, ENV['BRANCH'] || :master
set :deploy_to, "/home/#{fetch(:user)}/#{fetch(:application)}"
set :ssh_options, user: fetch(:user), keys: %w(~/.ssh/bitjourney_awskey.pem)
set :linked_dirs, %w(log tmp/pids tmp/cache)
set :bundle_binstubs, nil

set :rbenv_map_bins, %w(rake gem bundle ruby rails)
set :rbenv_type, :system
set :rbenv_ruby, '2.2.3'

set :unicorn_bin, 'unicorn_rails'

set :resque_log_file, 'log/resque.log'

after 'deploy:updated', 'deploy:migrate'
after 'deploy:finished', 'deploy:cleanup'
