class ShippingAddress < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :order
  belongs_to_active_hash :prefecture

  validates :zip_code, presence: true, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "must be in the format XXX-XXXX" }
  validates :prefecture_id, numericality: { other_than: 1, message: "must be selected" }
  validates :city, presence: true
  validates :street, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: "must be a half-width number with 10 to 11 digits" }
end
