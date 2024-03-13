class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_item, only: [:index, :new, :create]


  def index
    @orders = Order.all
    @order_address = OrderAddress.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if current_user
      redirect_to root_path unless @item && !@item.sold_out? && !current_user.id.eql?(@item.user_id)
    else
      redirect_to new_user_session_path
    end
  end

  def new
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    
    if @order_address.valid?  # バリデーションを実行して、必要な情報が入力されているかどうかを確認する
      pay_item(@order_address)
      if @order_address.save
        redirect_to root_path, notice: '購入が完了しました。'
      else
        # 保存中にエラーが発生した場合の処理
        flash.now[:alert] = '購入処理中にエラーが発生しました。'
        render 'index', status: :unprocessable_entity
      end
    else
      # 必要な情報が入力されていない場合の処理
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      flash.now[:alert] = '支払い情報が正しくありません。'
      render 'index', status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_address_params
    params.require(:order_address).permit(:phone_number, :zip_code, :city_id, :town, :house_number, :building_name).merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
  end

  def pay_item(order)
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: order_address_params[:token],   # カードトークン
      currency: 'jpy'      # 通貨の種類（日本円）
    )
  end
end
