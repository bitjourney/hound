app_path = '/home/journey/hound/current'
stderr_path "#{app_path}/log/unicorn-err.log"
stdout_path "#{app_path}/log/unicorn-out.log"

listen '/tmp/unicorn.sock', backlog: 2048
pid 'tmp/pids/unicorn.pid'

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_path}/Gemfile"
end

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 1)
timeout (ENV["UNICORN_TIMEOUT"] || 15).to_i
preload_app true

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
