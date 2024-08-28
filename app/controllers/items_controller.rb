class ItemsController < ApplicationController

  def index
      @items = Item.all
      @items = Item.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
  @item = Item.new(item_params)
  if @item.save
    redirect_to root_path
  else
    render :new, status: :unprocessable_entity
  end
  redirect_to '/'
  end

  private
  
  def item_params
    params.require(:item).permit(:name, :image, :information, :prefecture_id, :price, :scheduled_delivery_id, :shipping_fee_id, :category_id)
  end

end