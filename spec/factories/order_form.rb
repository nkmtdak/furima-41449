FactoryBot.define do
  factory :order_form do
    zip_code { '123-4567' }
    prefecture_id { 13 } # 東京都
    city { '渋谷区' }
    street { '1-1-1' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
