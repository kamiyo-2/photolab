require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it "textが存在すれば登録できる" do
        expect(@comment).to be_valid
      end
    end
    context 'コメント投稿がうまくいかないとき' do
      it 'コメント本文がない場合、無効にする' do
        @comment.text = ""
        @comment.valid?
        expect(@comment.errors.full_messages).to include("テキストを入力してください")
      end
    
      it 'コメント本文が200文字以上の場合、無効にする' do
        @comment.text = 'a' * 201
        @comment.valid?
        expect(@comment.errors.full_messages).to include("テキストは200文字以内で入力してください")
      end
    end
  end
end
