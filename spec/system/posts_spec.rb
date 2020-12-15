require 'rails_helper'

RSpec.describe '新規投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.build(:post,user_id: @user.id)
    @post_image = "#{Rails.root}/public/images/test_image.png"
    
    # @post = FactoryBot.build(:post,user_id: @user.id)
    # @post.post_image = Faker::Lorem.sentence
    # @post.save
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

      attach_file "post[post_image]",@post_image
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

RSpec.describe '投稿編集', type: :system do
  before do
    @post1 = FactoryBot.create(:post)
    @post2 = FactoryBot.create(:post)
    @post2.post_image_id = "c9b1ac550cce6defda9008c7f4d75c52b26a9252ec1f457da7ba94aecd10"
    @post2.text = "別ユーザーのテキスト"
    @post2.save
  end
  context '投稿編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した投稿の編集ができる' do
      # post1を投稿したユーザーでログインする
       visit new_user_session_path
      fill_in 'Eメールアドレス', with: @post1.user.email
      fill_in 'パスワード', with: @post1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 投稿の詳細ページに遷移することを確認する
      click_link "テキスト"
      # post1に「編集」ボタンがあることを確認する
        find('.nav_image').hover
        click_link '編集する'
        expect(current_path).to eq edit_post_path(@post1)
      # 編集ページへ遷移する
      visit edit_post_path(@post1)
      # 投稿内容を編集する
      attach_file "post[post_image]","#{Rails.root}/public/images/test_image.png"
      fill_in 'post_text', with: "#{@post1.text}+編集したテキスト"
      # 編集してもpostモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Post.count }.by(0)
      # 編集ページへ遷移する
      visit edit_post_path(@post1)
      # 編集には先ほど変更した内容の投稿が存在することを確認する（画像）
      expect(page).to have_selector "img"
      # 編集には先ほど変更した内容の投稿が存在することを確認する（テキスト）
      expect(page).to have_content("#{@post1.text}+編集したテキスト")
    end
  end
  context '投稿編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した投稿の編集画面には遷移できない' do
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
    it 'ログインしていないと投稿の編集画面には遷移できない' do
      # トップページにいる
      visit root_path
      # 投稿の詳細ページに遷移することを確認する
      click_link "別ユーザーのテキスト"
      # post1に「nav_image」画像がないことを確認する
      expect(page).to have_no_content('.nav_image')
    end
  end
end
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