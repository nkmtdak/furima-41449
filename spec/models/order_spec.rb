require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_form = FactoryBot.build(:order_form, user_id: user.id, item_id: item.id)
  end

  describe '商品購入' do
    context '購入できる場合' do
      it '全ての項目が正しく入力されていれば購入できる' do
        expect(@order_form).to be_valid
      end

      it '建物名が空でも購入できる' do
        @order_form.building = ''
        expect(@order_form).to be_valid
      end
    end

    context '購入できない場合' do
      it 'user_idが空では購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end

      it '郵便番号が空では購入できない' do
        @order_form.zip_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Zip code can't be blank")
      end

      it '郵便番号にハイフンがないと購入できない' do
        @order_form.zip_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Zip code must be a 7-digit number including a hyphen")
      end

      it '都道府県が選択されていないと購入できない' do
        @order_form.prefecture_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Prefecture must be selected")
      end

      it '市区町村が空では購入できない' do
        @order_form.city = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では購入できない' do
        @order_form.street = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Street can't be blank")
      end

      it '電話番号が空では購入できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では購入できない' do
        @order_form.phone_number = '123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number must be a 10 or 11-digit number")
      end

      it '電話番号が12桁以上では購入できない' do
        @order_form.phone_number = '123456789012'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number must be a 10 or 11-digit number")
      end

      it '電話番号に半角数字以外が含まれていると購入できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number must be a 10 or 11-digit number")
      end

      it 'トークンが空では購入できない' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end

  describe '#save' do
    context '保存できる場合' do
      it '有効な属性の場合、注文と配送先情報を作成すること' do
        expect { @order_form.save }.to change(Order, :count).by(1)
                                   .and change(ShippingAddress, :count).by(1)
      end
    end

    context '保存できない場合' do
      it '無効な属性の場合、注文と配送先情報を作成しないこと' do
        @order_form.zip_code = 'invalid'
        expect { @order_form.save }.to change(Order, :count).by(0)
                                   .and change(ShippingAddress, :count).by(0)
      end
    end
  end
end