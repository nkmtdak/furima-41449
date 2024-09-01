class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :check_item_availability
  before_action :check_if_own_item

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.item = @item
  
    if @order.valid? && process_payment
      @order.save
      redirect_to root_path, notice: '注文が完了しました'
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_item_availability
    redirect_to root_path, alert: 'この商品は購入できません' if @item.sold_out?
  end

  def check_if_own_item
    redirect_to root_path, alert: '自分の商品は購入できません' if current_user == @item.user
  end

  def order_params
    params.require(:order).permit(
      :token,
      shipping_address_attributes: [:zip_code, :prefecture_id, :city, :street, :building, :phone_number]
    )
  end

  def process_payment
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
    true
  rescue Payjp::PayjpError => e
    @order.errors.add(:base, "決済処理に失敗しました: #{e.message}")
    false
  end
end
