class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_params, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
    if Order.exists?(item_id: @item.id)
      redirect_to root_path
    elsif current_user.id != @item.user_id
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy if current_user.id == @item.user_id
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :text, :category_id, :state_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id,
                                 :price, images: []).merge(user_id: current_user.id)
  end

  def set_params
    @item = Item.find(params[:id])
  end


end
