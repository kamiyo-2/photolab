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
        expect(@comment.errors.full_messages).to include("Text can't be blank" )
      end
    
      it 'コメント本文が200文字以上の場合、無効にする' do
        @comment.text = 'a' * 201
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Text is too long (maximum is 200 characters)" )
      end
    end
  end
end
