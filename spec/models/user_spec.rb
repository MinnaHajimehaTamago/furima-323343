require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end

    context '新規登録ができる時' do
      it '必須項目が入力されていれば登録できること' do
        expect(@user).to be_valid
      end
      it 'passwordが6文字以上であれば登録できること' do
        @user.password = '123456a'
        @user.password_confirmation = '123456a'
        expect(@user).to be_valid
      end
      it 'first_nameが漢字・ひらがな・カタカナ（全角）であれば登録できること' do
        @user.first_name = '名前なまえナマエ'
        expect(@user).to be_valid
      end
      it 'last_nameが漢字・ひらがな・カタカナ（全角）であれば登録できること' do
        @user.last_name = '名前なまえナマエ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できない時' do
      it 'nicknameが空だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end

      it 'passwordが5字以下であれば登録できないこと' do
        @user.password = '1234a'
        @user.password_confirmation = '1234a'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'passwordが英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.password_confirmation = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて設定してください')
      end
      it 'passwordが数字のみでは登録できない' do
        @user.password = '111111'
        @user.password_confirmation = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードには英字と数字の両方を含めて設定してください')
      end
      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = '11111a'
        @user.password_confirmation = '22222b'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（全角）を入力してください')
      end

      it 'first_nameが漢字・ひらがな・カタカナ（全角）以外では登録できないこと' do
        @user.first_name = 'nameﾅﾏｴ'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（全角）は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名（全角）を入力してください')
      end

      it 'last_nameが漢字・ひらがな・カタカナ（全角）以外では登録できないこと' do
        @user.last_name = 'nameﾅﾏｴ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名（全角）は全角（漢字・ひらがな・カタカナ）で入力してください')
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（全角カナ）を入力してください')
      end
      it 'first_name_kanaがカタカナ以外では登録できない' do
        @user.first_name_kana = 'name'
        @user.valid?
        expect(@user.errors.full_messages).to include('姓（全角カナ）はカタカナで入力して下さい。')
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名（全角カナ）を入力してください')
      end
      it 'last_name_kanaがカタカナ以外では登録できない' do
        @user.last_name_kana = 'name'
        @user.valid?
        expect(@user.errors.full_messages).to include('名（全角カナ）はカタカナで入力して下さい。')
      end
      it 'birth_dateが空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
