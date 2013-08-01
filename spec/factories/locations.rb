FactoryGirl.define do
  factory :loc_no_user1, class: Location do
    accuracy 1.542
    altitude 25.2584023321
    bearing 42.2574053429
    latitude 12.2574053427
    longitude 62.2574053423
    provider 'gps'
    recorded_time { 1.second.ago }
    speed 4.542
  end
  
  factory :loc_no_user2, class: Location do
    accuracy nil
    altitude nil
    bearing nil
    latitude 12.2574153536
    longitude 62.2575251212
    provider 'network'
    recorded_time { 2.seconds.ago }
    speed nil
  end
end