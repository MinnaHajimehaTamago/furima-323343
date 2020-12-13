class Item < ApplicationRecord
  extend Active::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :days_to_ship
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :state

  with_options numericality: { other_than:1 } do
    validates :category_id
    validates :days_to_ship
    validates :delivery_fee
    validates :prefecture
    validates :state
  end
end
