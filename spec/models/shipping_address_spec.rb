require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  let(:shipping_address) { FactoryBot.build(:shipping_address) }

  describe 'バリデーション' do
    it 'すべての属性が有効な場合、有効であること' do
      expect(shipping_address).to be_valid
    end

    context '郵便番号(zip_code)' do
      it '存在しない場合、無効であること' do
        shipping_address.zip_code = nil
        expect(shipping_address).to be_invalid
        expect(shipping_address.errors[:zip_code]).to include("can't be blank")
      end

      it 'フォーマットが正しくない場合、無効であること' do
        shipping_address.zip_code = '1234567'
        expect(shipping_address).to be_invalid
        expect(shipping_address.errors[:zip_code]).to include("must be in the format 'XXX-XXXX'")
      end
    end

    context '都道府県(prefecture_id)' do
      it '選択されていない場合、無効であること' do
        shipping_address.prefecture_id = nil
        expect(shipping_address).to be_invalid
        expect(shipping_address.errors[:prefecture_id]).to include("must be selected")
      end
    end

    context '市区町村(city)' do
      it '存在しない場合、無効であること' do
        shipping_address.city = ''
        expect(shipping_address).to be_invalid
        expect(shipping_address.errors[:city]).to include("can't be blank")
      end
    end

    context '番地(street)' do
      it '存在しない場合、無効であること' do
        shipping_address.street = ''
        expect(shipping_address).to be_invalid
        expect(shipping_address.errors[:street]).to include("can't be blank")
      end
    end

    context '電話番号(phone_number)' do
      it '存在しない場合、無効であること' do
        shipping_address.phone_number = nil
        expect(shipping_address).to be_invalid
        expect(shipping_address.errors[:phone_number]).to include("can't be blank")
      end

      it '10桁未満の場合、無効であること' do
        shipping_address.phone_number = '123456789'
        expect(shipping_address).to be_invalid
        expect(shipping_address.errors[:phone_number]).to include("must be 10 or 11 digits long")
      end

      it '11桁を超える場合、無効であること' do
        shipping_address.phone_number = '123456789012'
        expect(shipping_address).to be_invalid
        expect(shipping_address.errors[:phone_number]).to include("must be 10 or 11 digits long")
      end
    end
  end
end