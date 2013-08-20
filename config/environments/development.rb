Miletracker::Application.configure do
  config.eager_load = false
  config.cache_classes = false
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = false
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
  
  config.assets.compress = false
  #config.assets.compile = false
  config.assets.compile = true
  #config.assets.debug = false
  config.assets.debug = true
  config.assets.digest = true
  #config.assets.digest = false
  
  config.serve_static_assets = true
  config.assets.compress = true
  config.assets.compile = false  
end
