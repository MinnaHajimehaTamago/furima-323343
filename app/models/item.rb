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
  has_many :item_tag_releations, dependent: :destroy
  has_many :tags, through: :item_tag_releations
  has_many :comments,dependent: :destroy

  def self.search(search)
    if search != ''
      Item.where('name LIKE(?)', "%#{search}%")
    else
      Item.includes(:user).order('created_at DESC')
    end
  end
end
