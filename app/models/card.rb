class Card < ApplicationRecord
  belongs_to :user
  with_options presence: true do
    validates :card_token, presence: { message: 'を正しく入力してください' }
    validates :customer_token
  end
end
