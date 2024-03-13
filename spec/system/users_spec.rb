require 'rails_helper'

RSpec.describe 'ユーザーログイン機能', type: :system do

  def basic_pass(path)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
    visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
  end

  it 'ログインに成功し、トップページに遷移する' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # サインインページへ移動する
    basic_pass root_path
    visit  new_user_session_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(page).to have_current_path(new_user_session_path)

    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'email', with: @user.email
    fill_in 'password', with: @user.password

    # ログインボタンをクリックする
    click_on('ログイン')
    sleep  1

    # トップページに遷移していることを確認する
    expect(page).to have_current_path(root_path)
  end

  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # 予め、ユーザーをDBに保存する
    @user = FactoryBot.create(:user)

    # サインインページへ移動する
    visit new_user_session_path

    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(page).to have_current_path(new_user_session_path)

    # 誤ったユーザー情報を入力する
    fill_in 'email', with: 'test'
    fill_in 'password', with: 'test'

    # ログインボタンをクリックする
    click_on('ログイン')

    # サインインページに戻ってきていることを確認する
    expect(page).to have_current_path(new_user_session_path)
  end
end