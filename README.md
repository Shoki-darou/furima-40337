# テーブル設計

## users テーブル

| Column             | Type    | Options                        |
| ------------------ | ------- | ------------------------------ |
| email              | string  | null: false, unique: true      |
| encrypted_password | string  | null: false                    |
| name               | string  | null: false                    |
| first_name         | string  | null: false                    |
| last_name          | string  | null: false                    |
| first_name_kana    | string  | null: false                    |
| last_name_kana     | string  | null: false                    |
| birthday           | date    | null: false                    |

### Association

- has_many :orders
- has_many :items


## items テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| item_name       | string     | null: false |
| content         | text       | null: false |
| category_id     | integer    | null: false |
| delivery_id     | integer    | null: false |
| city_id         | integer    | null: false |
| days_to_ship_id | integer    | null: false |
| price           | integer    | null: false |
| status_id       | integer    | null: false |
| user            | references | null: false, foreign_key: true |

### Association

- has_one :order
- belongs_to :user

## orders テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| phone_number  | string     | null: false                    |
| zip_code      | string     | null: false                    |
| city_id       | integer    | null: false                    |
| town          | string     | null: false                    |
| house_number  | string     | null: false                    |
| building_name | string     |                                |
| order         | references | null: false, foreign_key: true |


### Association

- belongs_to :order


## article モデル

- belongs_to :city_id
- belongs_to :category_id
- belongs_to :delivery_id
- belongs_to :days_to_ship_id
- belongs_to :status_id