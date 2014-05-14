class PlacesController < ApplicationController
  def index
    @places = current_user.places
  end
  
  def show
    @place = current_user.places.find(params[:id])
  end
  
  def new
    @place = current_user.places.new place_params
  end
  
  def edit
    @place = current_user.places.find(params[:id])
  end
  
  def update
    place = current_user.places.find(params[:id])
    place.update_attributes!(place_params)
    redirect_to action: 'index'
  end  
  
  private
    def place_params
      params.require(:place).permit(:summary, :description, :street, :city,
        :post_code)
    end
end
