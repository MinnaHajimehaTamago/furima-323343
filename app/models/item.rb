class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :days_to_ship
  belongs_to :delivery_fee
  belongs_to :prefecture
  belongs_to :state

  belongs_to :user
  has_many_attached :images
  has_one :order
  has_many :item_tag_releations
  has_many :tags, through: :item_tag_relations

  
end
