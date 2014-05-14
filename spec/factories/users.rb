FactoryGirl.define do
  factory :user do
    email 'j.tester@gmail.com'
    provider 'google'
    name 'John Test'
    password Devise.friendly_token[0,20]
    google_auth_token 'token'
    google_auth_refresh_token 'refresh_token'
    google_auth_expires_at Time.now + 1.day
  end

  factory :user2, class: User do
    email 'j.tester2@gmail.com'
    password Devise.friendly_token[0,20]
  end
end