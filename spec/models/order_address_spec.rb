require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  
  describe '商品購入機能' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.create(:item)
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_address).to be_valid
      end
      
      it 'building_nameは空でも保存できること' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'townが空だと保存できないこと' do
        @order_address.town = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Town can't be blank")
      end

      it 'zip_codeが空だと保存できないこと' do
        @order_address.zip_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Zip code can't be blank")
      end

      it 'zip_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @order_address.zip_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('Zip code は「3桁ハイフン4桁」の形式で入力してください')
      end

      it 'zip_codeは『３桁ハイフン４桁』半角英数字でないと保存できないこと' do
        @order_address.zip_code = '123-123４'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Zip code は「3桁ハイフン4桁」の形式で入力してください")
      end

      it 'cityが選択されていなければ保存できない' do
        @item.city_id = '1'
        @item.valid?
        expect(@item.errors.full_messages).to include("City Prefecture can't be blank")
      end

      it 'house_numberが空だと保存できないこと' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @order_address.phone_number = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下だと保存できないこと' do
        @order_address.phone_number = '090123456'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁以上11桁以内の半角数値のみ保存可能です")
      end
      it 'phone_numberが12桁以上だと保存できない' do
        @order_address.phone_number = '090123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁以上11桁以内の半角数値のみ保存可能です")
      end
      it 'phone_numberが半角数値でないと保存できないこと' do
        @order_address.phone_number = '０9012341234'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number は10桁以上11桁以内の半角数値のみ保存可能です")
      end

      it 'tokenが空では購入できないこと' do
        @purchase_address.token = nil
        @purchase_address.valid?
        expect(@purchase_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていないと保存できないこと' do
        @order_address.user_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていないと保存できないこと' do
        @order_address.item_id = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end