FactoryBot.define do
  factory :item do
    association :user

    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 300..9_999_999).to_i }
    information { Faker::Lorem.paragraph }
    category_id { Faker::Number.between(from: 2, to: 11) }
    condition_id { Faker::Number.between(from: 2, to: 7) }
    shipping_fee_id { Faker::Number.between(from: 2, to: 3) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    scheduled_delivery_id { Faker::Number.between(from: 2, to: 4) }

    after(:build) do |item|
      item.image.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'test_image.jpg')), filename: 'test_image.jpg',
                        content_type: 'image/jpeg')
    end
  end
end
