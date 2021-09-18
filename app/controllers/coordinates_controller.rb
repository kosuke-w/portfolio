class CoordinatesController < ApplicationController

  def new
    @items = Item.where(user_id: current_user.id)
    @coordinate = Coordinate.new
  end

  def create
    @coordinate = Coordinate.new(coordinate_params)
    @coordinate.user_id = current_user.id
    if @coordinate.save
      flash[:notice] = 'コーディネートを作成しました'
      redirect_to coordinates_path
    else
      @items = Item.where(user_id: current_user.id)
      render :new
    end
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
    @items = Item.where(user_id: current_user.id)
  end

  def update
    @coordinate = Coordinate.find(params[:id])
    if @coordinate.update(coordinate_params)
      flash[:notice] = 'コーディネート情報を更新しました'
      redirect_to coordinate_path(@coordinate.id)
    else
      @items = Item.where(user_id: current_user.id)
      render :edit
    end
  end

  def destroy
    coordinate = Coordinate.find(params[:id])
    coordinate.destroy
    flash[:notice] = 'コーディネートを削除しました'
    redirect_to coordinates_path
  end

  private
  def coordinate_params
    params.require(:coordinate).permit(:user_id, :name, :comment, :season, { :item_ids=> [] })
  end

end
