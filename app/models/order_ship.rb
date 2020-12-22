class OrderShip

  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipalities, :address,
                :building_name, :tel, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'はハイフンありの7桁で入力してください'}
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :municipalities
    validates :address
    validates :tel, format: { with: /\A\d{10,11}\z/, message: 'はハイフンなしで正しく入力してください'}
    validates :token, presence: { message: 'は正しく入力してください' }
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Ship.create(postal_code: postal_code, prefecture_id: prefecture_id, municipalities: municipalities, address: address, building_name: building_name, tel: tel, order_id: order.id)
  end

end