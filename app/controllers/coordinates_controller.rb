class CoordinatesController < ApplicationController

  def new
    @items = Item.where(user_id: current_user.id)
    @coordinate = Coordinate.new
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    @coordinate.user_id = current_user.id
    @coordinate.save
    redirect_to coordinates_path
  end

  def index
    @coordinates = Coordinate.where(user_id: current_user.id)
    @record = Record.new
  end

  def show
    @coordinate = Coordinate.find(params[:id])
  end

  def edit
    @coordinate = Coordinate.find(params[:id])
    @items = Item.all
  end

  def update
    @coordinate = Coordinate.find(params[:id])
    @coordinate.update(coordinate_params)
    redirect_to coordinate_path(@coordinate.id)
  end

  def destroy
    @coordinate = Coordinate.find(params[:id])
    @coordinate.destroy
    redirect_to coordinates_path
  end

  private
  def coordinate_params
    params.require(:coordinate).permit(:user_id, :comment, :season, { :item_ids=> [] })
  end

end
