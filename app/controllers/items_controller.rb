class ItemsController < ApplicationController
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save
      flash[:notice] = 'アイテムを追加しました'
      redirect_to items_path
    else
      render :new
    end
  end

  def index
    @items = Item.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = 'アイテム情報を更新しました'
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    flash[:notice] = 'アイテムを削除しました'
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:user_id, :name, :image, :genre, :color, :price, :brand, :caption)
  end
end
