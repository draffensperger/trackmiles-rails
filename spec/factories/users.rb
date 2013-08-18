FactoryGirl.define do
  factory :user do
    email 'j.tester@gmail.com'
    provider 'google'
    name 'John Test'
    password Devise.friendly_token[0,20]
    google_auth_token 'token'    
  end
end