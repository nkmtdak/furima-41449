class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :check_item_availability
  before_action :check_if_own_item

  def index
    @order_form = OrderForm.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY'] # ここで公開鍵をgonにセット
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
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
    params.require(:order_form).permit(
      :zip_code, :prefecture_id, :city, :street, :building, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
