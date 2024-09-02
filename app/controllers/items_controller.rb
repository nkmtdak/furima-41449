class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  before_action :check_item_availability, only: [:edit, :update]

  def index
    @items = Item.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: 'Item was successfully deleted.'
  end

  private

  def item_params
    params.require(:item).permit(
      :image, :name, :information, :category_id, :condition_id,
      :shipping_fee_id, :prefecture_id, :scheduled_delivery_id, :price
    )
  end

  def set_item
    @item = Item.find_by(id: params[:id])
    redirect_to root_path if @item.nil?
  end

  def ensure_correct_user
    redirect_to root_path unless @item.user == current_user
  end

  def check_item_availability
    redirect_to root_path if @item.sold_out?
  end
end
