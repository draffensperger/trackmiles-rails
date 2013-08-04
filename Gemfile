source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.11'
gem 'devise'
gem 'omniauth-google-oauth2'
gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'
gem 'figaro'
gem 'rest-client'
gem 'versionist'

group :production do
  gem 'pg'
  gem 'thin'
end

group :development, :test do  
  gem 'sqlite3'
    
  gem 'libv8', :platforms => :ruby
  gem 'therubyracer', :platforms => :ruby
  gem 'execjs', :platforms => :ruby
  
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'rspec-rails'
  
  gem 'test-unit'
  gem 'spork-rails'
  #gem 'spork-rails', :platforms => :ruby
  #gem 'spork-testunit', :platforms => :ruby
end

group :test do
  gem 'webmock'
end

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end
