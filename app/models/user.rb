class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nickname, presence: true
  validates :first_name, presence: true
  validates :family_name, presence: true
  validates :birth_date, presence: true

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: ' is invalid. Include both letters and numbers' }

  # お名前(全角)のバリデーション
  validates :family_name, :first_name, presence: true
  validates :family_name, :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/,}

  # お名前カナ(全角)のバリデーション
  validates :family_name_kana, :first_name_kana, presence: true
  validates :family_name_kana, :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/ ,}
end