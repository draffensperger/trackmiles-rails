class PlacesController < ApplicationController
  def index
    @places = Place.all       
  end
  
  def show
    @place = Place.find(params[:id])
  end
  
  def new
    @place = Place.new place_params
  end
  
  def edit
    @place = Place.find(params[:id])
  end
  
  def update
    place = Place.find(params[:id])
    place.update_attributes!(place_params)
    redirect_to action: 'index'
  end  
  
  private
    def place_params
      params.require(:place).permit(:summary, :description, :street, :city,
        :post_code)
    end
end
