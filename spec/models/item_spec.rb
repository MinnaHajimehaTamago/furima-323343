require 'rails_helper'

RSpec.describe Item, type: :model do
    before do
      @item = FactoryBot.build(:item)
    end

    context '商品が登録できる時' do
      it '必須項目が入力されていれば登録できること' do
        expect(@item).to be_valid
      end
      it 'category_idが1以外であれば登録できること' do
        @item.category_id = '2'
        expect(@item).to be_valid
      end
      it 'state_idが1以外であれば登録できること' do
        @item.state_id = '2'
        expect(@item).to be_valid
      end
      it 'delivery_fee_idが1以外であれば登録できること' do
        @item.delivery_fee_id = '2'
        expect(@item).to be_valid
      end
      it 'prefecture_idが1以外であれば登録できること' do
        @item.prefecture_id = '2'
        expect(@item).to be_valid
      end
      it 'days_to_ship_idが1以外であれば登録できること' do
        @item.days_to_ship_id = '2'
        expect(@item).to be_valid
      end
      it 'priceが300以上9999999以下であれば登録できること（最小値）' do
        @item.price = 300
        expect(@item).to be_valid
      end
      it 'priceが300以上9999999以下であれば登録できること（最大値）' do
        @item.price = 9999999
        expect(@item).to be_valid
      end
    end

    context '商品が登録できない時' do
      it 'imageが空だと登録できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('出品画像を選択してください')
      end
      it 'nameが空だと登録できないこと' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名を入力してください')
      end
      it 'textが空だと登録できないこと' do
        @item.text = ""
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'category_idが1だと登録できないこと' do
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'state_idが1だと登録できないこと' do
        @item.state_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'delivery_fee_idが1だと登録できないこと' do
        @item.delivery_fee_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'prefecture_idが1だと登録できなこと' do
        @item.prefecture_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'days_to_ship_idが1だと登録できないこと' do
        @item.days_to_ship_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'priceが空だと登録できないこと' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は¥300~9,999,999で入力してください', '販売価格は半角数字で入力してください')
      end
      it 'priceが299以下だと登録できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は¥300~9,999,999で入力してください')
      end
      it 'priceが10000000以上だと登録できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は¥300~9,999,999で入力してください')
      end
      it 'priceが半角数字以外では登録できないこと' do
        @item.price = "３００"
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は半角数字で入力してください')
      end
    end
end
