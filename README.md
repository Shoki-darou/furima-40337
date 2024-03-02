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

- has_many :purchases
- has_many :orders
- has_many :items
- has_one :ordaddresser

## items テーブル

| Column    | Type       | Options     |
| --------- | ---------- | ----------- |
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

- has_many :purchases
- has_one :order
- belongs_to :user

## orders テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |
| address       | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user
- has_one :address

## addresses テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| phone_number  | string     | null: false                    |
| zip_code      | string     | null: false                    |
| city_id       | integer    | null: false                    |
| town          | string     | null: false                    |
| house_number  | string     | null: false                    |
| Building_name | string     |                                |
| user          | references | null: false, foreign_key: true |


### Association

- belongs_to :orders
- belongs_to :user


## purchases テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user


## article モデル

- belongs_to :city
- belongs_to :category_id
- belongs_to :delivery_id
- belongs_to :days_to_ship_id
- belongs_to :status_id