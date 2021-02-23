class CardsController < ApplicationController
  before_action :set_card, only: :destroy 

  def new
    @card = Card.new
  end

  def create
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer = Payjp::Customer.create(
      description: 'test',
      card: params[:card_token]
    )
    @card = Card.new(
      card_token: params[:card_token],
      customer_token: customer.id,
      user_id: current_user.id
    )
    if @card.valid?
      @card.save
      redirect_to user_path(current_user.id)
    else
      render action: :new
    end
  end
  
  def destroy
    @card.destroy if current_user.id == @card.user_id
    redirect_to user_path(current_user.id)
  end

  private

  def set_card
    @card = Card.find_by(user_id: current_user.id)
  end

end
