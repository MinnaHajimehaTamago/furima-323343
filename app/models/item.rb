class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :days_to_ship
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :state

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image, presence: { message: 'を選択してください' }
    validates :name
    validates :text
  end

  validates :price,
            numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'は¥300~9,999,999で入力してください' }
  validates :price, numericality: { only_integer: true, message: 'は半角数字で入力してください' }

  with_options presence: true, numericality: { other_than: 1, message: 'を選択してください' } do
    validates :category_id
    validates :days_to_ship_id
    validates :delivery_fee_id
    validates :prefecture_id
    validates :state_id
  end
end
