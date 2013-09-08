source 'https://rubygems.org'

#ruby '2.0.0'
ruby '1.9.3'

gem 'rails', '~>4.0.0'
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
gem 'sidekiq'
gem 'geocoder'
gem 'activerecord-import', '~>0.4.1'

gem 'sass-rails'
gem 'coffee-rails'
gem 'coffee-script-source', '1.5.0'
gem 'uglifier'

gem 'rails_12factor'

gem 'pg'

group :production do  
  gem 'thin'
  gem 'mysql2'
end

group :development, :test do    
  gem 'execjs', :platforms => :ruby
  
  gem 'factory_girl_rails'
  gem 'simplecov'
  gem 'rspec-rails' 
  
  gem 'test-unit'  
  #gem 'spork-rails', :platforms => :ruby
  #gem 'spork-testunit', :platforms => :ruby
  
  gem 'libv8', :platforms => :ruby  
  gem 'therubyracer', :platforms => :ruby 
end

group :test do
  gem 'sqlite3'
  gem 'webmock'
  gem 'autotest-rails'
  gem 'spork-rails', :git => 'git://github.com/sporkrb/spork-rails.git'
  gem 'guard-spork' 
end