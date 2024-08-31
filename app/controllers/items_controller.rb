class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy, :ensure_correct_user]
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

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
      :image,
      :name,
      :information,
      :category_id,
      :condition_id,
      :shipping_fee_id,
      :prefecture_id,
      :scheduled_delivery_id,
      :price
    )
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def ensure_correct_user
    return if @item.user == current_user

    redirect_to root_path
  end
end
