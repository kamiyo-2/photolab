require 'rails_helper'
require "refile/file_double"

RSpec.describe Post, type: :model do
  before do
    @post = FactoryBot.build(:post)
    @post.post_image = Refile::FileDouble.new("dummy", "logo.png", content_type: "image/png")
    @post.save
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
      expect(@post.errors.full_messages).to include("Post image can't be blank")
    end
    it "textが空だと登録できない" do
      @post.text = ""
      @post.valid?
      expect(@post.errors.full_messages).to include("Text can't be blank")
    end
  end
end
