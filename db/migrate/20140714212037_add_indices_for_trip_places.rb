class AddIndicesForTripPlaces < ActiveRecord::Migration
  def change
    add_index "trips", "start_place_id"
    add_index "trips", "end_place_id"
  end
end
