class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :zip_code, :prefecture_id, :city, :street, :building, :phone_number, :token

  # バリデーションの追加
  validates :user_id, :item_id, :zip_code, :prefecture_id, :city, :street, :phone_number, :token, presence: true
  validates :zip_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'must be a 7-digit number including a hyphen' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'must be a 10 or 11-digit number' }
  
  # 都道府県のバリデーションを追加
  validates :prefecture_id, numericality: { greater_than: 1, less_than_or_equal_to: 48, message: 'must be selected' }

  def save
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id: user_id, item_id: item_id)
      ShippingAddress.create!(
        order_id: order.id, 
        zip_code: zip_code,
        prefecture_id: prefecture_id,
        city: city,
        street: street,
        building: building,
        phone_number: phone_number
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
