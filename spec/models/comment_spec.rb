require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'コメント投稿機能' do
    before do
      @comment = FactoryBot.build(:comment)
    end

    context 'コメント情報が登録できる時' do
      it 'textが正しく入力されていれば登録できること' do
        expect(@comment).to be_valid
      end
    end

    context 'コメント情報が登録できない時' do
      it 'textが空では登録できないこと' do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Textを入力してください")
      end
      it 'user情報が紐づいていないと登録できないこと' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
