class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :shipping_fee
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :scheduled_delivery

  validates :name, presence: true
  validates :image, presence: true
  validates :price, presence: true, numericality: {
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999,
    only_integer: true
  }
  validates :information, presence: true

  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :scheduled_delivery_id,
            presence: true, numericality: { other_than: 1 }
end
