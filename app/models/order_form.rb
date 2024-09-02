class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :zip_code, :prefecture_id, :city, :street, :building, :phone_number, :token

  def save
    ActiveRecord::Base.transaction do
      order = Order.create!(user_id:, item_id:, prefecture_id:)
      ShippingAddress.create!(
        order_id: order.id,
        zip_code:,
        prefecture_id:,
        city:,
        street:,
        building:,
        phone_number:
      )
    end
  end
end
