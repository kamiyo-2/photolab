require 'rails_helper'
require "refile/file_double"

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
    
  end

  describe '新規投稿機能がうまくいくとき' do

    it "text,post_imageが存在すれば登録できる" do
      expect(@post).to be_valid
    end
  end

  context '新規投稿機能がうまくいかないとき' do 
    it "imageが空だと登録できない" do
      @post.post_image = nil
      @post.valid?
      expect(@post.errors.full_messages).to include("画像を入力してください")
    end
    it "textが空だと登録できない" do
      @post.text = ""
      @post.valid?
      expect(@post.errors.full_messages).to include("テキストを入力してください")
    end
  end
end
