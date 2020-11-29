class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text        :text,           null: false
      t.string      :post_image_id,  null: false
      t.references  :user,           foreign_key: true
      t.timestamps
    end
  end
end
