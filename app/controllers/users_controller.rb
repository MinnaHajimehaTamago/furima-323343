class UsersController < ApplicationController
  def show
    if Card.find_by(user_id: current_user.id).present?
      @user = User.find(params[:id])
      Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
      card = Card.find_by(user_id: current_user.id)
      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      redirect_to action: :show
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :first_name, :last_name, :first_name_kana, :last_name_kana, :birth_date, :email,
                                 :password, :password_confirmation)
  end
end
