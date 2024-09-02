class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :order
  belongs_to_active_hash :prefecture

  # バリデーションをFormオブジェクトに移動するため、ここでは最小限のバリデーションのみを保持
  validates :order_id, presence: true
  validates :prefecture_id, presence: true
end
