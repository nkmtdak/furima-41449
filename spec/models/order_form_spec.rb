require 'rails_helper'
RSpec.describe OrderForm, type: :model do
  let!(:user) { create(:user) }
  let!(:item) { create(:item, user: user) }
  let(:order_form) { build(:order_form, user_id: user.id, item_id: item.id) }

  describe 'バリデーション' do
    context '正常な場合' do
      it '全ての値が正しく入力されていれば保存できること' do
        expect(order_form).to be_valid
      end
    end

    context '異常な場合' do
      it '郵便番号が空では保存できないこと' do
        order_form.zip_code = ''
        expect(order_form).to be_invalid
        expect(order_form.errors.full_messages).to include("Zip code can't be blank")
      end

      it '郵便番号にハイフンがないと保存できないこと' do
        order_form.zip_code = '1234567'
        expect(order_form).to be_invalid
        expect(order_form.errors.full_messages).to include("Zip code must be a 7-digit number including a hyphen")
      end

      it '都道府県が選択されていないと保存できないこと' do
        order_form.prefecture_id = 1
        expect(order_form).to be_invalid
        # puts order_form.errors.full_messages
        expect(order_form.errors.full_messages).to include("Prefecture must be selected")
      end

      it '市区町村が空では保存できないこと' do
        order_form.city = ''
        expect(order_form).to be_invalid
        expect(order_form.errors.full_messages).to include("City can't be blank")
      end

      it '番地が空では保存できないこと' do
        order_form.street = ''
        expect(order_form).to be_invalid
        expect(order_form.errors.full_messages).to include("Street can't be blank")
      end

      it '電話番号が空では保存できないこと' do
        order_form.phone_number = ''
        expect(order_form).to be_invalid
        expect(order_form.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が9桁以下では保存できないこと' do
        order_form.phone_number = '123456789'
        expect(order_form).to be_invalid
        expect(order_form.errors.full_messages).to include("Phone number must be a 10 or 11-digit number")
      end

      it '電話番号が12桁以上では保存できないこと' do
        order_form.phone_number = '123456789012'
        expect(order_form).to be_invalid
        expect(order_form.errors.full_messages).to include("Phone number must be a 10 or 11-digit number")
      end

      it '電話番号に半角数字以外が含まれている場合は保存できないこと' do
        order_form.phone_number = '090-1234-5678'
        expect(order_form).to be_invalid
        expect(order_form.errors.full_messages).to include("Phone number must be a 10 or 11-digit number")
      end

      it 'トークンが空では保存できないこと' do
        order_form.token = ''
        expect(order_form).to be_invalid
        expect(order_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end