
# User

| Column             | Type    | Options                   |
| ------------------ | ------  | ------------------------- |
| nick_name          | string  | null: false               |
| email              | string  | null: false, unique: true |
| password           | string  | null: false               |
| family_name        | string  | null: false               |
| first_name         | string  | null: false               |
| family_name_kana   | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_date         | date    | null: false               |

### Association

- has_many :items
- has_many :purchase_records

# Items 

| Column                | Type       | Options                         |
| --------------------  | ---------- | ------------------------------  |
| user                  | references | null: false, foreign_key: true  |
| name                  | string     | null: false                     |
| price                 | integer    | null: false                     |
| information           | text       | null: false                     |
| category_id           | integer    | null: false                     |
| condition_id          | integer    | null: false                     |
| shipping_fee_id       | integer    | null: false                     |
| prefecture_id         | integer    | null: false                     |
| scheduled_delivery_id | integer    | null: false                     |

### Association

- belongs_to :user
- has_one :purchase_record

# Purchase_records

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

# Shipping_addresses

| Column         | Type        | Options                         |
| -------------- | ----------  | ------------------------------  |
| purchase_record|references	 |null: false, foreign_key: true   |
| zip_code       | string      | null: false                     |
| prefecture_id  | integer     | null: false                     |
| city           | string      | null: false                     |
| street         | string      | null: false                     |
| building       | string      |                                 |
| phone_number   | string      | null: false                     |

### Association

- belong_to :purchase_record
