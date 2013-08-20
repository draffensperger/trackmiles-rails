require 'spork'

# Not sure why this is necessary to work with spork, but it seems to be.
# It raises an error if I run it in the debugger though.
begin
  require 'hash_ext'
rescue LoadError
end

Spork.prefork do
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'webmock/rspec'  
  
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
  
  RSpec.configure do |config|  
    config.include FactoryGirl::Syntax::Methods
    
    config.include Devise::TestHelpers, :type => :controller
    
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
  
    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    config.use_transactional_fixtures = true
  
    # If true, the base class of anonymous controllersu will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  
    # Run specs in random order to surface order dependencies. If you find an
    # order dependency and want to debug it, you can fix the order by providing
    # the seed, which is printed after each run.
    #     --seed 1234
    config.order = "random"
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  FactoryGirl.reload
  #Dir[Rails.root.join("app/roles/**/*.rb")].each {|f| require f}
  #Dir[Rails.root.join("../../lib/*.rb")].each {|f| require f}  
end

def stub_invalid_google_token
  stub_token_for_user "INVALID_GOOGLE_TOKEN", nil
end

def stub_google_token(user = nil)
  stub_token_for_user "GOOGLE_TOKEN", user || create(:user)
end

def stub_token_for_user(token, user)
  User.should_receive(:find_or_create_for_google_token)
    .at_least(1).times.with(token).and_return(user)
  user.google_auth_token = token if user 
  $user = user
  token
end  

def user_for_stubbed_login
  $user
end