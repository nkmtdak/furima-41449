
# User

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nick_name          | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| family_name        | string | null: false               |
| first_name         | string | null: false               |
| family_name_kana   | string | null: false               |
| first_name_kana    | string | null: false               |
| date_of_birth      | date   | null: false               |

# Items 

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| user            | references | null: false, foreign_key: true |
| name            | string     | null: false                    |
| image           | string     |                                |
| price           | integer    | null: false                    |
| information     | text       | null: false                    |
| category        | string     | null: false                    |
| condition       | string     | null: false                    |
| shipping_fee    | string     | null: false                    |
| comment         | text       |                                |

# Purchase_records

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |
| purchase_date | date       | null: false                    |

# Shipping_addresses

| Column         | Type       | Options                        |
| -------------- | ---------- | ------------------------------ |
| purchase_record| references | null: false, foreign_key: true |
| zip_code       | string     | null: false                    |
| address        | text       | null: false                    |
| shipping_name  | string     | null: false                    |
| shipping_tel   | string     | null: false                    |