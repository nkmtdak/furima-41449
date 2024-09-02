FactoryBot.define do
  factory :shipping_address do
    zip_code { '123-4567' }
    prefecture_id { 2 } # 1以外の値を設定
    city { '東京都' }
    street { '1-1' }
    building { '東京ハイツ' }
    phone_number { '09012345678' }
    association :order
  end
end
