set :stage, :staging

app_server = %w(app-misc-001)
role :app, app_server
role :db, app_server

role :resque_worker, app_server
role :resque_scheduler, app_server

namespace :deploy do
  task :copy_dotenv do
    on roles(:app) do
      execute "cp -vf /home/#{fetch(:user)}/#{fetch(:application)}/shared/.env #{release_path}/.env"
    end
  end

  task :restart_unicorn do
    on roles(:app) do
      invoke 'unicorn:restart'
    end
  end
end

after 'deploy:updating', 'deploy:copy_dotenv'
after 'deploy:publishing', 'deploy:restart_unicorn'
