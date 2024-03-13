require 'rails_helper'

def basic_pass(path)               
  username = ENV['BASIC_AUTH_USER'] 
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe '商品出品機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end

  context '新規投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      basic_pass root_path
      sign_in(@user)
      # 投稿ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      attach_file 'item-image', Rails.root.join('public/images/test_image.png')
      fill_in 'item-name', with: @item.item_name
      fill_in 'item-info', with: @item.content
      select 'レディース', from: 'item-category'
      select '新品・未使用', from: 'item-sales-status'
      select '着払い(購入者負担)', from: 'item-shipping-fee-status'
      select '北海道', from: 'item-prefecture'
      select '1~2発送', from: 'item-scheduled-delivery'
      fill_in 'item-price', with: @item.price.to_i
      # 送信するとItemモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      # トップページに遷移する
      visit root_path
    end
  end
  context '新規投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      basic_pass root_path
      visit new_item_path
      # ログインページにリダイレクトされることを確認する
      expect(page).to have_current_path(new_user_session_path)
    end
  end 
end