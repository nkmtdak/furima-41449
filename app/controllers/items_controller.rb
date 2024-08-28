class ItemsController < ApplicationController

  def index
    @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item
    else
      render :new, status: :unprocessable_entity
    end

  end

  private
  
  def item_params
    params.require(:item).permit.permit(:name, :information, :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :scheduled_delivery_id, :price, :image)
  end

end