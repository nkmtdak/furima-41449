class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :check_item_availability
  before_action :check_if_own_item

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order = Order.new
    @order.build_shipping_address
  end

  def create
    Rails.logger.info "Received params: #{params.inspect}"
    @order = Order.new(order_params)
    @order.user = current_user
    @order.item = @item
  
    if @order.valid?
      begin
        ActiveRecord::Base.transaction do
          process_payment(@item.price)
          @order.save!
          redirect_to root_path, notice: '注文が完了しました' and return
        end
      rescue => e
        Rails.logger.error "Order creation failed: #{e.message}"
        flash.now[:alert] = '注文の処理に失敗しました'
        render :index
      end
    else
      flash.now[:alert] = '注文情報に問題があります'
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
      shipping_address_attributes: [:zip_code, :prefecture_id, :city, :street, :building, :phone_number]
    ).merge(item_id: params[:item_id], token: params[:token])
  end

  def process_payment(price)
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: price,
      card: order_params[:token],
      currency: 'jpy'
    )
  rescue Payjp::PayjpError => e
    Rails.logger.error "Payment processing failed: #{e.message}"
    @order.errors.add(:base, "決済処理に失敗しました: #{e.message}")
    raise e
  end
end
