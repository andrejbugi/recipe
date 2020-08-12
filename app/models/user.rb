class User < ApplicationRecord
  MAXIMUM_EMAIL_LENGTH = 64
  MAXIMUM_USERNAME_LENGTH = 64
  MINIMUM_PASSWORD_LENGTH = 8
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  before_save :email_to_downcase

  has_secure_password

  has_many :meal_recipes, dependent: :destroy
  has_many :recipe_instructions, dependent: :destroy
  has_many :recipe_ingredients, dependent: :destroy

  validates :username, presence: true, length: { maximum: MAXIMUM_USERNAME_LENGTH }
  validates :email, presence: true, length: { maximum: MAXIMUM_EMAIL_LENGTH },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, presence: true, length: { minimum: MINIMUM_PASSWORD_LENGTH }

  private

  def email_to_downcase
    self.email = email.downcase
  end
end
