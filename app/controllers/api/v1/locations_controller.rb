class Api::V1::LocationsController < Api::V1::BaseController
  def bulk_create
    old_num_locs = current_user.locations.count
    current_user.locations.build(params[:locations])
    current_user.save    
    render json: {num_created_locations: current_user.locations.count - old_num_locs}     
  end
end
