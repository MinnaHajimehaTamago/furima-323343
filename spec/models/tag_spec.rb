require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'タグ付機能' do
    before do
      @tag = FactoryBot.build(:tag)
    end

    context 'タグ情報が登録できる時' do
      it 'tag_nameが入力されていれば登録できること' do
        expect(@tag).to be_valid
      end
    end
  end
end
