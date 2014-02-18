class TripSeparatorWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = Users.find_by_id user_id
    if user
      TripSeparator.new(user).calc_and_save_trips
    end    
  end
end