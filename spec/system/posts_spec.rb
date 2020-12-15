require 'rails_helper'

RSpec.describe '投稿削除', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
    @post2.post_image_id = "c9b1ac550cce6defda9008c7f4d75c52b26a9252ec1f457da7ba94aecd10"
    @post2.text = "別ユーザーのテキスト"
    @post2.save
  end
  context '投稿削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した投稿の削除ができる' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿の詳細ページに遷移することを確認する
      click_link "テキスト"
      # post1に「削除」ボタンがあることを確認する
        find('.nav_image').hover 
       have_link '削除する', href: post_path(@post1)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find('.nav_image').hover
        find_link('削除する', href: post_path(@post1)).click
      }.to change { Post.count }.by(-1)
      # トップページに遷移する
      visit root_path
      # トップページにはpost1の内容が存在しないことを確認する（画像）
      expect(page).to have_no_content "img"
      # トップページにはpost1の内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content "(@post1.text)" 
    end
  end
  context '投稿削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した投稿の削除ができない' do
      # post1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'Eメールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿の詳細ページに遷移することを確認する
      click_link "別ユーザーのテキスト"
      # post2に「nav_image」画像がないことを確認する
      expect(page).to have_no_content('.nav_image')
    end
    it 'ログインしていないと投稿の削除ボタンがない' do
      # トップページにいる
      visit root_path
      # 投稿の詳細ページに遷移することを確認する
      click_link "別ユーザーのテキスト"
      # post1に「nav_image」画像がないことを確認する
      expect(page).to have_no_content('.nav_image')
    end
  end
end