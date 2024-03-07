class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  
  def index
    @items = Item.all.order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to '/'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    if current_user == @item.user && @item.sold_out?
      redirect_to root_path
    elsif current_user != @item.user
      redirect_to root_path
    end
  end
  
  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user == @item.user
      @item.destroy
      redirect_to root_path, notice: "商品情報を削除しました"
    else
      redirect_to root_path, alert: "権限がありません"
    end
  end
  private
  def item_params
    params.require(:item).permit(:item_name, :content, :price, :category_id, :delivery_id, :city_id, :days_to_ship_id, :status_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
