class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  
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
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if current_user == @item.user && @item.sold_out?
      redirect_to root_path
    elsif current_user != @item.user
      redirect_to root_path
    end
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end
=begin
  def destroy
    prototype = Item.find(params[:id])
    prototype.destroy
    redirect_to '/'
  end
=end

  private
  def item_params
    params.require(:item).permit(:item_name, :content, :price, :category_id, :delivery_id, :city_id, :days_to_ship_id, :status_id, :image).merge(user_id: current_user.id)
  end

end
