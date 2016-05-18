ruby '2.3.1'

source 'https://rubygems.org'

gem 'activerecord-import'
gem 'devise'
gem 'geocoder'
gem 'gon'
gem 'haml-rails'
gem 'haml'
gem 'jquery-rails'
gem 'kramdown'
gem 'omniauth-google-oauth2'
gem 'rails'
gem 'rest-client'
gem 'tzinfo-data'
gem 'tzinfo'
gem 'versionist'

gem 'sass-rails'
gem 'coffee-rails'
gem 'coffee-script-source', '1.5.0'
gem 'uglifier'

gem 'rails_12factor'

# Will phase out sidekiq soon
gem 'sidekiq'
gem 'sidekiq-unique-jobs'

# I like to be able to test and benchmark different servers and platforms.
gem 'pg', :platforms => :ruby

group :production do
  #gem 'activerecord-jdbcpostgresql-adapter', :platforms => :jruby
  #gem 'puma'
  #gem 'unicorn', :platforms => :ruby

  gem 'thin', :platforms => :ruby
  gem 'newrelic_rpm'
end

group :development do
  gem 'quiet_assets'
  gem 'rubocop', '0.40'
end

group :development, :test do
  gem 'execjs', :platforms => :ruby

  gem 'dotenv-rails'

  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'rspec-rails'

  gem 'test-unit'

  gem 'http_logger'

  gem 'ZenTest'

  gem 'spring'
  gem 'guard-spring'

  gem 'capybara'
  gem 'selenium-webdriver'
end

group :test do
  gem 'rake'
  gem 'webmock'
  gem 'rspec-autotest'
  #gem 'spork', git: 'git://github.com/codecarson/spork'
  #gem 'spork-rails', git: 'git://github.com/sporkrb/spork-rails.git'
  #gem 'spork-rails'
  #gem 'guard-spork'
end
