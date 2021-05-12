class ItemTag
  include ActiveModel::Model
  attr_accessor :name, :text, :category_id, :state_id, :delivery_fee_id, :prefecture_id, :days_to_ship_id, :price, :user_id,
                :images, :tag_names, :tag_name

  with_options presence: true do
    validates :images, presence: { message: 'を選択してください' }
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

  def save
    item = Item.create(name: name, text: text, category_id: category_id, state_id: state_id, delivery_fee_id: delivery_fee_id,
                       prefecture_id: prefecture_id, days_to_ship_id: days_to_ship_id, price: price, user_id: user_id, images: images)
    tag_names.uniq.each do |name|
      tag = Tag.where(tag_name: name).first_or_initialize
      tag.save
      ItemTagReleation.create(item_id: item.id, tag_id: tag.id)
    end
    unless tag_name == ''
      tag = Tag.where(tag_name: tag_name).first_or_initialize
      tag.save
      ItemTagReleation.create(item_id: item.id, tag_id: tag.id)
    end
  end
end
