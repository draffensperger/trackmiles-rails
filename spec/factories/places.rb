# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :place do
  end

  factory :home, class: Place do
    latitude 42.3761107
    longitude -71.19307544
  end

  factory :home2, class: Place do
    latitude 42.37797703
    longitude -71.19176888
  end

  factory :far_away, class: Place do
    latitude 42.71806182
    longitude -73.81185664
  end

  factory :home_other_user, class: Place do
    latitude 42.3761107
    longitude -71.19307544
  end
end
