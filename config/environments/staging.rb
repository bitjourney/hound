require_relative "production"

Houndapp::Application.configure do
  config.action_mailer.default_url_options = { :host => ENV['HOST'] }
  config.assets.compress = false
  config.assets.compile = true
  config.assets.digest = false
end
