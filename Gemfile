source 'https://rubygems.org'

# This is useful for the Dokku deployment, but centralizes the Ruby version
ruby File.new('.ruby-version').read.chomp

gem 'rails'
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'
gem 'rest-client'
gem 'versionist'
gem 'kramdown'
gem 'tzinfo'
gem 'tzinfo-data'
gem 'geocoder'
gem 'activerecord-import'
gem 'gon'

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
  
group :development, :test do
  gem 'execjs', :platforms => :ruby

  gem 'figaro'

  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'rspec-rails' 
  
  gem 'test-unit'

  gem 'http_logger'
  
  gem 'libv8', :platforms => :ruby  
  gem 'therubyracer', :platforms => :ruby

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