set :stage, :staging

app_server = %w(dev-001)
role :app, app_server
role :db, app_server

role :resque_worker, app_server
role :resque_scheduler, app_server
# set :workers, { "my_queue_name" => 2 }

namespace :deploy do
  task :copy_dotenv do
    on roles(:app) do
      execute "cp -vf ~/env #{release_path}/.env"
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
