class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :orders
  has_many :items

  validates :name,            presence: true
  validates :first_name,      presence: true
  validates :last_name,       presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana,  presence: true
  validates :birthday,        presence: true
  validates :encrypted_password, presence: true, confirmation: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validate :password_complexity

  private

  def password_complexity
    return if encrypted_password.blank? || password =~ /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]+$/

    errors.add :encrypted_password, 'Password is invalid. Include both letters and numbers'
  end
end
