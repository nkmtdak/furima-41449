class Order < ApplicationRecord
  belongs_to :user
  belongs_to :item
  has_one :shipping_address
  accepts_nested_attributes_for :shipping_address
  attr_accessor :token

  validates :token, presence: true
end
