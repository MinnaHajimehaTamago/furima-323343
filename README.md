# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| first_name       | string | null: false |
| last_name        | string | null: false |
| first_name_kana  | string | null: false |
| last_nama_kana   | string | null: false |
| birth_data       | data   | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| name            | string     | null: false                    |
| text            | text       | null: false                    |
| category        | string     | null: false                    |
| state           | string     | null: false                    |
| delivery_fee    | string     | null: false                    |
| shipment_source | string     | null: false                    |
| days_to_ship    | string     | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one_attached :image
- has_one :order

## orders テーブル

| Column   | Type       | Options                           |
| -------- | ---------- | --------------------------------- |
| user     | references | null: false, foreign_key: true    |
| item     | references | null: false, foreign_key: true    |

### Association

- belongs_to :user
- belongs_to :item
- has_one :ship

## ships テープル

| Column         | Type   | Options                            |
| -------------- | ------ | -----------------------------------|
| postal_code    | string | null: false                        |
| prefecture     | string | null: false                        |
| municipalities | string | null: false                        |
| address        | string | null: false                        |
| building_name  | string |                                    |
| order          | references | null: false, foreign_key: true |

### Association

- belongs_to :order


# heroku URL
<!-- https://furima-323343.herokuapp.com/ -->