class SyncCalendarsWorker
  include Sidekiq::Worker

  def perform(user_id)
    ActiveRecord::Base.connection_pool.with_connection do
      user = User.find(user_  id)
      begin
        user.sync_calendars
      rescue e
        nil
      end
    end
  end
end