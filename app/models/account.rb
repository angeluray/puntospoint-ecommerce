class Account < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

    has_many :products, dependent: :destroy
    has_many :sales
    has_many :categories

    validates :email, presence: true, uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP }

    validates :password, presence: true,
              length: { minimum: 8 },
              format: { with: /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?[\d])(?=.*?[\W])\S{8,}\z/ }

    validates :first_name, presence: true, length: { maximum: 50 }
    validates :last_name, presence: true, length: { maximum: 50 }
end