require 'rails_helper'

RSpec.describe ShippingAddress, type: :model do
  before do
    @shipping_address = FactoryBot.build(:shipping_address)
  end

  describe '配送先情報の保存' do
    context '配送先情報を保存できる場合' do
      it '全ての項目が正しく入力されていれば保存できる' do
        expect(@shipping_address).to be_valid
      end

      it '建物名が空でも保存できる' do
        @shipping_address.building = ''
        expect(@shipping_address).to be_valid
      end
    end

    context '配送先情報を保存できない場合' do
      it '郵便番号が空では保存できない' do
        @shipping_address.zip_code = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Zip code can't be blank")
      end

      it '郵便番号が「3桁ハイフン4桁」の形式でないと保存できない' do
        @shipping_address.zip_code = '1234567'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include('Zip code must be in the format XXX-XXXX')
      end

      it '都道府県が選択されていないと保存できない' do
        @shipping_address.prefecture_id = 1
        @shipping_address.valid?
        expect(@shipping_address.errors[:prefecture_id]).to include('must be selected')
      end

      it '市区町村が空では保存できない' do
        @shipping_address.city = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では保存できない' do
        @shipping_address.street = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Street can't be blank")
      end

      it '電話番号が空では保存できない' do
        @shipping_address.phone_number = ''
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では保存できない' do
        @shipping_address.phone_number = '123456789'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include('Phone number must be a half-width number with 10 to 11 digits')
      end

      it '電話番号が12桁以上では保存できない' do
        @shipping_address.phone_number = '123456789012'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include('Phone number must be a half-width number with 10 to 11 digits')
      end

      it '電話番号にハイフンが含まれていると保存できない' do
        @shipping_address.phone_number = '090-1234-5678'
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include('Phone number must be a half-width number with 10 to 11 digits')
      end

      it '注文が紐付いていないと保存できない' do
        @shipping_address.order = nil
        @shipping_address.valid?
        expect(@shipping_address.errors.full_messages).to include('Order must exist')
      end
    end
  end
end
