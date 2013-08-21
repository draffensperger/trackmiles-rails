class TripsController < ApplicationController
  def index
    #SyncCalendarsWorker.perform_async current_user.id
    current_user.sync_calendars
  end
end
