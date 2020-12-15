FactoryBot.define do
  factory :post do
    post_image_id         {"22950a4634589cec99f990a99f424641abd421f6109a3c11be545d8f72ad"}
    text                  {"テキスト"}
    association :user             
    
  end
end

    # post_image_id         {"22950a4634589cec99f990a99f424641abd421f6109a3c11be545d8f72ad"}
 
# {"#{Rails.root}/public/images/test_image.png"}
# @post = FactoryBot.build(:post, user_id: user.id)
# @post = FactoryBot.build(:post,user_id: @user.id)