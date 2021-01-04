require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'カード情報登録機能' do
    before do
      @card = FactoryBot.build(:card)
    end

    context 'カード情報が登録できる時' do
      it '全ての値が正しく入力されていれば登録できること' do
        expect(@card).to be_valid
      end
    end

    context 'カード情報が登録できない時' do
      it 'card_tokenが空だと登録できないこと' do
        @card.card_token = nil
        @card.valid?
        expect(@card.errors.full_messages).to include('カード情報を正しく入力してください')
      end
      it 'customer_tokenが空だと登録できないこと' do
        @card.customer_token = nil
        @card.valid?
        expect(@card.errors.full_messages).to include('Customer tokenを入力してください')
      end
      it 'ユーザー情報が紐づいていないと登録できないこと' do
        @card.user = nil
        @card.valid?
        expect(@card.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
