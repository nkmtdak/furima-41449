class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :first_name, presence: true
  validates :family_name, presence: true
  validates :email, presence: true

  validates :birth_date, presence: true
    # メールアドレスが必須、一意性、@を含む
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i ,}

  # パスワード関連のバリデーション
  validates :password, presence: true, length: { minimum: 6 }
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i ,}
  validates :password, confirmation: true
  validates :password_confirmation, presence: true

  # お名前(全角)のバリデーション
  validates :family_name, :first_name, presence: true
  validates :family_name, :first_name, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/ ,}

  # お名前カナ(全角)のバリデーション
  validates :family_name_kana, :first_name_kana, presence: true
  validates :family_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ ,}
end
