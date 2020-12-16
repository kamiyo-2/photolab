

# テーブル設計

## users テーブル

| Column     | Type   | Options     |
| ---------- | ------ | ----------- |
| email      | string | null: false |
| password   | string | null: false |
| name       | string | null: false |
| profile    | text   | null: false |

### Association
- has_many :posts
- has_many :comments
- has_many :likes
- has_many :active_relationships
- has_many :passive_relationships
- has_many :followings
- has_many :followers


## posts テーブル
| Column        | Type         | Options           |
| ------------- | ------------ | ----------------- |
| text          | string       | null: false       |
| post_image_id | string       | null: false       |
| user          | references   | foreign_key: true |

### Association
- belongs_to :users
- has_many   :comments
- has_many   :likes
- attachment :post_image


## comments テーブル

| Column     | Type         | Options           |
| ---------- | ------------ | ----------------- |
| text       | text         | null: false       |
| user       | references   | foreign_key: true |
| post       | references   | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post


## likes テーブル

| Column     | Type         | Options           |
| ---------- | ------------ | ----------------- |
| user       | references   | foreign_key: true |
| prototype  | references   | foreign_key: true |

### Association
- belongs_to :user
- belongs_to :post



## follews テーブル

| Column     | Type         | Options                         |
| ---------- | ------------ | ------------------------------- |
| user       | belongs_to   | foreign_key: true               |
|target_user | belongs_to   | null: false, foreign_key: false |

### Association

- belongs_to :user
- belongs_to :target_user





