source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '~> 3.2.14'
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'
gem 'figaro'
gem 'rest-client'
gem 'versionist'
gem 'redcarpet'
gem 'tzinfo'
gem 'tzinfo-data'
gem 'google-api-client', '~> 0.6.4', :require => 'google/api_client'

group :production do
  gem 'pg'
  gem 'thin'
end

group :development, :test do  
  gem 'sqlite3'
  
  gem 'execjs', :platforms => :ruby
  
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'rspec-rails' 
  
  gem 'test-unit'
  gem 'spork-rails'
  #gem 'spork-rails', :platforms => :ruby
  #gem 'spork-testunit', :platforms => :ruby
  
  gem 'libv8', :platforms => :ruby  
  gem 'therubyracer', :platforms => :ruby
end

group :test do
  gem 'webmock'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'coffee-script-source', '1.5.0'
  gem 'uglifier'
end
