class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_params

  def index
    redirect_to new_card_path and return unless current_user.card.present?

    judge_seller
    judge_sold
    @order_ship = OrderShip.new
    set_card_info
  end

  def create
    @order_ship = OrderShip.new(order_params)
    if @order_ship.valid?
      pay_item
      @order_ship.save
      redirect_to root_path
    else
      set_card_info
      render :index
    end
  end

  private

  def order_params
    params.require(:order_ship).permit(:postal_code, :prefecture_id, :municipalities, :address, :building_name, :tel).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def set_params
    @item = Item.find(params[:item_id])
  end

  def set_card_info
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    card = Card.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(card.customer_token)
    @card = customer.cards.first
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price,
      customer: customer_token,
      currency: 'jpy'
    )
  end

  def judge_seller
    redirect_to root_path if current_user.id == @item.user_id
  end

  def judge_sold
    redirect_to root_path if Order.exists?(item_id: @item.id)
  end
end
