require 'rails_helper'

def basic_pass(path)               
  username = ENV['BASIC_AUTH_USER'] 
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe '商品購入機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @order_address = FactoryBot.create(:order_address, user: @user)
    @item = FactoryBot.create(:item)
  end

  context '新規投稿ができるとき' do
    it 'ログインしたユーザーは商品を購入できる' do
      # ログインする
      sign_in(@user)
      # 投稿ページに移動する
      visit item_orders_path(@item)
      # フォームに情報を入力する
      fill_in 'card_number', with: '4242424242424242'
      fill_in 'card_expiry', with: '04/26'
      fill_in 'card_cvc', with: '123'
      fill_in 'zip_code', with: @order_address.zip_code
      select '北海道', from: 'prefecture'
      fill_in 'city', with: @order_address.town
      fill_in 'house_number', with: @order_address.house_number
      fill_in 'building_name', with: @order_address.building_name
      fill_in 'phone_number', with: @order_address.phone_number
      # 送信するとItemモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
    end
  end

  context '商品が購入できないとき' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit item_orders_path(@item)
      # ログインページにリダイレクトされることを確認する
      expect(current_path).to eq new_user_session_path
    end
  end 
end