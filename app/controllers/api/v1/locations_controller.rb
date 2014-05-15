class Api::V1::LocationsController < Api::V1::BaseController
  def bulk_create
    render json: {
        num_created_locations:
          Location.bulk_create_and_process(current_user, params[:locations])
    }
  end
end