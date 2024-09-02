class OrderForm
  include ActiveModel::Model

  attr_accessor :user_id, :item_id, :zip_code, :prefecture_id, :city, :street, :building, :phone_number, :token

  # バリデーションの追加
  validates :user_id, :item_id, :zip_code, :prefecture_id, :city, :street, :phone_number, :token, presence: true
  validates :zip_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンを含む7桁の数字で入力してください' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の数字で入力してください' }

  def save
    # バリデーションチェック
    return false unless valid?

    ActiveRecord::Base.transaction do
      order = Order.create!(user_id:, item_id:, prefecture_id:)
      ShippingAddress.create!(
        order_id: order.id, # order_idを指定
        zip_code:,
        prefecture_id:,
        city:,
        street:,
        building:,
        phone_number:
      )
    end
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
