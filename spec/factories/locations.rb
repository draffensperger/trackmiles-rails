FactoryGirl.define do
  factory :loc_no_user1, class: Location do
    accuracy 1.542
    altitude 25.2584023321
    bearing 42.2574053429
    latitude 12.2574053427
    longitude 62.2574053423
    provider 'gps'
    recorded_time DateTime.new(2012,2,3,4,5,6)
    speed 4.542
  end
  
  factory :loc_no_user2, class: Location do
    accuracy nil
    altitude nil
    bearing nil
    latitude 19.2574153536
    longitude 63.2575251212
    provider 'network'
    recorded_time DateTime.new(2013,3,4,6,7,8)
    speed nil
  end
  
  factory :location do
    accuracy 1.542
    altitude 25.2584023321
    bearing 42.2574053429
    latitude 12.2574053427
    longitude 62.2574053423
    provider 'gps'
    recorded_time DateTime.new(2012,2,3,4,5,6)
    speed 4.542
    user
  end  
end