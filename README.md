# テーブル設計

## users テーブル

| Column             | Type    | Options                        |
| ------------------ | ------- | ------------------------------ |
| name               | string  | null: false                    |
| email              | string  | null: false, unique: true      |
| password_digest    | string  | null: false                    |
| address            | string  | null: false                    |
| birthday           | string  | null: false                    |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column    | Type       | Options     |
| --------- | ---------- | ----------- |
| item_name | string     | null: false |
| content   | text       | null: false |
| price     | string     | null: false |
| status    | string     | null: false |
| user      | references | null: false, foreign_key: true |

### Association

- has_one :order
- belongs_to :user

## orders テーブル

| Column      | Type       | Options                        |
| ----------- | ---------- | ------------------------------ |
| total_price | references | null: false                    |
| user        | references | null: false, foreign_key: true |
| item        | references | null: false, foreign_key: true |

### Association

- belongs_to :item
- belongs_to :user