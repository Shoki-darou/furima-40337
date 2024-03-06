require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '新規投稿' do
    context '投稿できる場合' do
      it '全ての項目の入力がが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
    context '投稿できない場合' do
      it 'item_nameが空では保存できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Item name can't be blank")
      end
      it 'contentが空では保存できない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'imageが空では保存できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image must be attached")
      end
      it 'categoryが選択されていなければ保存できない' do
        @item.category = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Category can't be blank")
      end
      it 'deliveryが選択されていなければ保存できない' do
        @item.delivery = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery Shipping fee status can't be blank")
      end
      it 'cityが選択されていなければ保存できない' do
        @item.city = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("City Prefecture can't be blank")
      end
      it 'days_to_shipが選択されていなければ保存できない' do
        @item.days_to_ship = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship Scheduled delivery can't be blank")
      end
      it 'priceが空では保存できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが半角数字でなければ保存できない' do
        @item.price = '１２３４５'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end
      it 'priceが0以下の値では保存できない' do
        @item.price = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Price must be greater than 0")
      end
      it 'statusが選択されていなければ保存できない' do
        @item.status = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Status Sales status can't be blank")
      end
      it '紐づくユーザーが存在しないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end
    end
  end
end