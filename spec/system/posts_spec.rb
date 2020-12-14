require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post)
    @post.post_image = Faker::Lorem.sentence
    @post.save
  end
  context '新規投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'Eメールアドレス', with: @user.email
      fill_in 'パスワード', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('New Post')
      # 投稿ページに移動する
      visit new_post_path
      # フォームに情報を入力する

      attach_file "post[post_image]","#{Rails.root}/public/images/test_image.png"
      fill_in 'post_text', with: @post.text
      # 送信するとPostモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(1)
      # トップページに遷移することを確認する
      visit root_path
      # トップページには先ほど投稿した内容の画像が存在することを確認する（画像）
      expect(page).to have_selector "img"
      # トップページには先ほど投稿した内容のテキストが存在することを確認する（テキスト）
      expect(page).to have_content(@post.text)
      # トップページには先ほど投稿した投稿にユーザーの名前が存在することを確認する（テキスト）
      expect(page).to have_content(@post.user.name)
    end
  end
  context '新規投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('New Post')
    end
  end
end
[src="#{Rails.root}/public/images/test_image.png"]