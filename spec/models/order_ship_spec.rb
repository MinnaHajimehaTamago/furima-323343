require 'rails_helper'

RSpec.describe OrderShip, type: :model do
  describe '商品購入機能' do
    before do
      @order_ship = FactoryBot.build(:order_ship)
    end

    context '商品購入情報が登録できる時' do
      it 'すべての値が正しく入力されていれば登録できること' do
        expect(@order_ship).to be_valid
      end
      it 'building_nameが空でも登録できること' do
        @order_ship.building_name = ""
        @order_ship.valid?
        expect(@order_ship).to be_valid
      end
    end

    context '商品購入情報が登録できない時' do
      it 'postal_codeが空だと登録できないこと' do
        @order_ship.postal_code = ""
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("郵便番号を入力してください", "郵便番号はハイフンありの7桁で入力してください")
      end
      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと登録できないこと' do
        @order_ship.postal_code = "1234567"
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("郵便番号はハイフンありの7桁で入力してください")
      end
      it 'prefecture_idが1だと登録できないこと' do
        @order_ship.prefecture_id = "1"
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("都道府県を選択してください")
      end
      it 'municipalitiesが空だと登録できないこと' do
        @order_ship.municipalities = ""
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("市区町村を入力してください")
      end
      it 'addressが空だと登録できないこと' do
        @order_ship.address = ""
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("番地を入力してください")
      end
      it 'telが空だと登録できないこと' do
        @order_ship.tel = ""
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("電話番号を入力してください", "電話番号はハイフンなしで正しく入力してください")
      end
      it 'telが9桁以下だと登録できないこと' do
        @order_ship.tel = "123456789"
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("電話番号はハイフンなしで正しく入力してください")
      end
      it 'telが12桁以上だと登録できないこと' do
        @order_ship.tel = "123456789012"
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("電話番号はハイフンなしで正しく入力してください")
      end
      it 'tokenが空だと登録できないこと' do
        @order_ship.token = nil
        @order_ship.valid?
        expect(@order_ship.errors.full_messages).to include("クレジットカード情報は正しく入力してください")
      end
    end
    end
end
