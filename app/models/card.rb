class Card < ApplicationRecord
  belongs_to :user

  validates :card_token, presence: true, presence: { message: 'を正しく入力してください' }
end
