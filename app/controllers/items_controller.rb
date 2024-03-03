class ItemsController < ApplicationController

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to '/'
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def edit
    @item = Item.find(params[:id])
    unless user_signed_in?
      redirect_to action: :index
    end
  end
  
  def update
    item = Item.find(params[:id])
    item.update(prototype_params)
    if item.save
      redirect_to item_path(item.id)
    else
      render :edit
    end
  end

  def destroy
    prototype = Item.find(params[:id])
    prototype.destroy
    redirect_to '/'
  end

  private
    def item_params
      params.require(:item).permit(:item_name, :content, :price, :category_id, :delivery_id, :city_id, :days_to_ship_id, :status_id, :image).merge(user_id: current_user.id)
    end
end
